import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:shared/libs.dart';
import 'package:shared/shared.dart';
import 'package:synchronized/synchronized.dart';

// Helper class to store request context
class _QueuedRequest {
  final Completer<Response> completer;
  final RequestOptions requestOptions;

  _QueuedRequest(this.completer, this.requestOptions);
}

/// Manages Dio HTTP client with automatic token refresh and retry logic.
class DioClient {
  DioClient(this.instance, this.sessionManager) {
    instance.interceptors.add(InterceptorsWrapper(onRequest: _onRequest, onError: _onError));
  }

  final Dio instance;
  final Dio _refreshDio = Dio();
  final SessionManager sessionManager;

  final Lock _refreshLock = Lock();
  final List<_QueuedRequest> _requestQueue = [];

  // retry settings
  final int _maxRetries = 3;
  final Duration _initialDelay = const Duration(milliseconds: 300);

  Future<void> _onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final session = await sessionManager.session;
    if (session != null) {
      options.headers.addAll(_tokenHeader(session));
    }

    handler.next(options);
  }

  Future<void> _onError(DioException error, ErrorInterceptorHandler handler) async {
    final response = error.response;
    final session = await sessionManager.session;

    // Handle token expiration first
    if (response != null && session != null && _shouldRefresh(response)) {
      return _handleTokenRefresh(error, handler, session);
    }

    // Handle retryable errors with backoff
    if (_shouldRetry(error)) {
      try {
        final retried = await _retryWithBackoff(error.requestOptions);
        return handler.resolve(retried);
      } on DioException catch (error) {
        return handler.next(error);
      }
    }

    return handler.next(error);
  }

  Future<void> _handleTokenRefresh(DioException error, ErrorInterceptorHandler handler, SessionModel session) async {
    final completer = Completer<Response>();
    final queuedRequest = _QueuedRequest(completer, error.requestOptions);
    _requestQueue.add(queuedRequest);

    await _refreshLock.synchronized(() async {
      final currentSession = await sessionManager.session;

      // if token was refreshed already while waiting, then skip refreshing
      if (currentSession != null && currentSession.accessToken != session.accessToken) {
        return;
      }

      try {
        final newSession = await _refreshToken(session, _refreshDio);
        await sessionManager.storeSession(newSession);

        // Process all queued requests with the new session
        final futures = _requestQueue.map((queuedRequest) {
          final retry = _retry(queuedRequest.requestOptions, newSession);
          return retry.then(queuedRequest.completer.complete).catchError(queuedRequest.completer.completeError);
        }).toList();

        await Future.wait(futures, eagerError: false);
      } catch (refreshError) {
        // If refresh fails, clear session and fail all queued requests
        await sessionManager.clearSession();

        for (final queuedRequest in _requestQueue) {
          if (refreshError is DioException) {
            queuedRequest.completer.completeError(refreshError);
          } else {
            queuedRequest.completer.completeError(
              DioException(requestOptions: error.requestOptions, error: refreshError),
            );
          }
        }
      } finally {
        _requestQueue.clear();
      }
    });

    try {
      final result = await completer.future;
      handler.resolve(result);
    } catch (completeError) {
      if (completeError is DioException) {
        handler.next(completeError);
      } else {
        handler.next(DioException(requestOptions: queuedRequest.requestOptions, error: completeError));
      }
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions, SessionModel session) async {
    final options = Options(
      method: requestOptions.method,
      headers: {...requestOptions.headers, ..._tokenHeader(session)},
      responseType: requestOptions.responseType,
      contentType: requestOptions.contentType,
      followRedirects: requestOptions.followRedirects,
      validateStatus: requestOptions.validateStatus,
      sendTimeout: requestOptions.sendTimeout,
      receiveTimeout: requestOptions.receiveTimeout,
      listFormat: requestOptions.listFormat,
    );

    return instance.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      cancelToken: requestOptions.cancelToken,
      options: options,
      onSendProgress: requestOptions.onSendProgress,
      onReceiveProgress: requestOptions.onReceiveProgress,
    );
  }

  Future<Response<dynamic>> _retryWithBackoff(RequestOptions requestOptions) async {
    int attempt = 0;
    late DioException lastError;

    while (attempt < _maxRetries) {
      try {
        return await instance.fetch(requestOptions);
      } on DioException catch (error) {
        lastError = error;
        attempt++;

        if (attempt >= _maxRetries || !_shouldRetry(error)) {
          rethrow;
        }

        // Exponential backoff with jitter
        final delay = _initialDelay * pow(2, attempt);
        final jitter = Duration(milliseconds: Random().nextInt(100));
        await Future.delayed(delay + jitter);
      }
    }

    throw lastError;
  }

  bool _shouldRetry(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return true;
    }

    final status = error.response?.statusCode ?? 0;
    return [
      HttpStatus.internalServerError,
      HttpStatus.badGateway,
      HttpStatus.serviceUnavailable,
      HttpStatus.gatewayTimeout,
    ].contains(status);
  }

  Map<String, String> _tokenHeader(SessionModel session) {
    return {'Authorization': '${session.tokenType} ${session.accessToken}'};
  }

  bool _shouldRefresh(Response? response) {
    return response?.statusCode == HttpStatus.unauthorized;
  }

  Future<SessionModel> _refreshToken(SessionModel? session, Dio client) async {
    // TODO: implement refresh token call
    throw UnimplementedError('Refresh token logic is not implemented');
  }
}
