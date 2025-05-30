import 'dart:io';

import 'package:core/src/data/local/token/token_operation.dart';
import 'package:core/src/models/jwt.dart';
import 'package:dio/dio.dart';

typedef TokenHeaderBuilder = Map<String, String> Function(Jwt token);

typedef RefreshToken = Future<Jwt> Function(Jwt? token, Dio client);

typedef ShouldRefresh = bool Function(Response? response);

class RevokeTokenException implements Exception {}

class ApiClient {
  ApiClient(this.httpClient, this.tokenOperation) {
    httpClient.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onResponse: _onResponse,
        onError: _onError,
      ),
    );
  }

  final Dio httpClient;
  final Dio _localHttpClient = Dio();
  final TokenOperation tokenOperation;

  Future<dynamic> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final currentToken = await tokenOperation.token;
    final headers =
        currentToken != null
            ? _tokenHeader(currentToken)
            : const <String, String>{};
    options.headers.addAll(headers);
    handler.next(options);
  }

  Future<dynamic> _onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    return handler.next(response);
  }

  Future<dynamic> _onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final response = error.response;
    if (response == null ||
        await tokenOperation.token == null ||
        error.error is RevokeTokenException ||
        !_shouldRefresh(response)) {
      return handler.next(error);
    }
    try {
      final refreshResponse = await _tryRefresh(response);
      handler.resolve(refreshResponse);
    } on DioException catch (error) {
      handler.next(error);
    }
  }

  Future<Response> _tryRefresh(Response response) async {
    late final Jwt refreshedToken;
    try {
      refreshedToken = await _refreshToken(
        await tokenOperation.token,
        _localHttpClient,
      );
    } on RevokeTokenException catch (error) {
      await tokenOperation.clearToken();
      throw DioException(
        requestOptions: response.requestOptions,
        error: error,
        response: response,
      );
    }

    await tokenOperation.setToken(refreshedToken);
    _localHttpClient.options.baseUrl = response.requestOptions.baseUrl;
    return _localHttpClient.request<dynamic>(
      response.requestOptions.path,
      cancelToken: response.requestOptions.cancelToken,
      data: response.requestOptions.data,
      onReceiveProgress: response.requestOptions.onReceiveProgress,
      onSendProgress: response.requestOptions.onSendProgress,
      queryParameters: response.requestOptions.queryParameters,
      options: _builldRequestOptions(response, refreshedToken),
    );
  }

  Options _builldRequestOptions(Response response, Jwt refreshedToken) {
    return Options(
      method: response.requestOptions.method,
      sendTimeout: response.requestOptions.sendTimeout,
      receiveTimeout: response.requestOptions.receiveTimeout,
      extra: response.requestOptions.extra,
      headers:
          response.requestOptions.headers..addAll(_tokenHeader(refreshedToken)),
      responseType: response.requestOptions.responseType,
      contentType: response.requestOptions.contentType,
      validateStatus: response.requestOptions.validateStatus,
      receiveDataWhenStatusError:
          response.requestOptions.receiveDataWhenStatusError,
      followRedirects: response.requestOptions.followRedirects,
      maxRedirects: response.requestOptions.maxRedirects,
      requestEncoder: response.requestOptions.requestEncoder,
      responseDecoder: response.requestOptions.responseDecoder,
      listFormat: response.requestOptions.listFormat,
    );
  }

  TokenHeaderBuilder get _tokenHeader => (Jwt token) {
    return {'Authorization': '${token.tokenType} ${token.accessToken}'};
  };

  ShouldRefresh get _shouldRefresh => (Response? response) {
    return response?.statusCode == HttpStatus.unauthorized;
  };

  RefreshToken get _refreshToken => (Jwt? token, Dio client) async {
    // TODO: Implement refresh token logic
    return Jwt(accessToken: '', refreshToken: '');
  };
}
