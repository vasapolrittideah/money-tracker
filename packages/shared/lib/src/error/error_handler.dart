import 'dart:developer';
import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared/gen/l10n.dart';
import 'package:shared/src/contract/api_response.dart';
import 'package:shared/src/error/exceptions.dart';
import 'package:shared/src/error/failure.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

/// Handles exceptions and maps them to appropriate [Failure].
class ErrorHandler {
  /// Handles errors from the given [operation] and maps them to [Failure].
  ///
  /// Returns an [Either] containing either the successful result of type [T]
  /// or an [Failure] in case of an error.
  static Future<Either<Failure, T>> handle<T>(Future<T> Function() operation) async {
    try {
      final result = await operation();
      return Right(result);
    } catch (error, stackTrace) {
      log(
        'Error occurred',
        name: 'ErrorHandler',
        error: error,
        stackTrace: stackTrace,
        level: 1000, // SEVERE
      );

      final thirdPartyFailure = _handleThirdPartyServiceError(error, stackTrace: stackTrace);
      if (thirdPartyFailure != null) {
        return Left(thirdPartyFailure);
      }

      if (error is DioException) {
        return Left(_handleDioError(error, stackTrace));
      }

      final l10n = SharedLocalizations.current;

      if (error is SocketException) {
        return Left(Failure.noInternetConnection(l10n.errorNoInternetConnection, stackTrace: stackTrace));
      }

      if (error is FormatException) {
        return Left(Failure.dataParsingError(l10n.errorDataParsing, stackTrace: stackTrace));
      }

      if (error is HiveError || error is CacheException) {
        return Left(Failure.cacheError(l10n.errorCache, stackTrace: stackTrace));
      }

      return Left(Failure.unidentified(l10n.errorUnknown, stackTrace: stackTrace));
    }
  }

  /// Maps a [DioException] to an appropriate [Failure].
  ////
  /// Inspects the type of Dio error and constructs a corresponding [Failure]
  /// with a localized message.
  static Failure _handleDioError(DioException error, StackTrace? stackTrace) {
    final l10n = SharedLocalizations.current;

    // Sometimes Dio wraps the real error (e.g., SocketException) inside DioException.
    if (error.error is SocketException) {
      return Failure.noInternetConnection(l10n.errorNoInternetConnection, stackTrace: stackTrace);
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Failure.connectionTimeout(l10n.errorConnectionTimeout, stackTrace: stackTrace);

      case DioExceptionType.sendTimeout:
        return Failure.sendTimeout(l10n.errorSendTimeout, stackTrace: stackTrace);

      case DioExceptionType.receiveTimeout:
        return Failure.receiveTimeout(l10n.errorReceiveTimeout, stackTrace: stackTrace);

      case DioExceptionType.cancel:
        return Failure.cancelled(l10n.errorCancelled, stackTrace: stackTrace);

      case DioExceptionType.connectionError:
        return Failure.connectionError(l10n.errorConnectionError, stackTrace: stackTrace);

      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response, stackTrace);

      default:
        return Failure.unidentified(l10n.errorUnknown, stackTrace: stackTrace);
    }
  }

  /// Handles bad HTTP responses and extracts meaningful error information.
  ///
  /// Analyzes the [response] to extract status code and error message and constructs
  /// an [Failure] with the relevant details.
  static Failure _handleBadResponse(Response? response, StackTrace? stackTrace) {
    final statusCode = response?.statusCode ?? HttpStatus.internalServerError;

    final apiResponse = response != null && response.data is Map<String, dynamic>
        ? ApiResponse.fromJson(response.data as Map<String, dynamic>)
        : null;

    var message = apiResponse?.error?.message ?? _getMessageFromStatusCode(statusCode);
    var errorCode = apiResponse?.error?.code ?? '';

    return Failure(statusCode: statusCode, errorCode: errorCode, message: message, stackTrace: stackTrace);
  }

  /// Handles errors from third-party services and maps them to [Failure].
  static Failure? _handleThirdPartyServiceError(Object error, {StackTrace? stackTrace}) {
    if (error is GoogleSignInException) {
      return Failure.thirdPartyServiceError(error.description ?? '', stackTrace: stackTrace);
    }

    if (error is FacebookSignInException) {
      return Failure.thirdPartyServiceError(error.message ?? '', stackTrace: stackTrace);
    }

    return null;
  }

  /// Maps common HTTP status codes to user-friendly messages.
  ///
  /// Returns a localized message for the given [statusCode]. If the status code
  /// is not recognized, returns a generic unknown error message.
  static String _getMessageFromStatusCode(int statusCode) {
    final l10n = SharedLocalizations.current;

    return switch (statusCode) {
      HttpStatus.badRequest => l10n.errorBadRequest,
      HttpStatus.unauthorized => l10n.errorUnauthorized,
      HttpStatus.forbidden => l10n.errorForbidden,
      HttpStatus.notFound => l10n.errorNotFound,
      HttpStatus.conflict => l10n.errorConflict,
      HttpStatus.unprocessableEntity => l10n.errorUnprocessable,
      HttpStatus.tooManyRequests => l10n.errorTooManyRequests,
      HttpStatus.internalServerError => l10n.errorInternalServer,
      HttpStatus.serviceUnavailable => l10n.errorServiceUnavailable,
      HttpStatus.badGateway => l10n.errorBadGateway,
      HttpStatus.gatewayTimeout => l10n.errorGatewayTimeout,
      _ => l10n.errorUnknownCode(statusCode),
    };
  }
}
