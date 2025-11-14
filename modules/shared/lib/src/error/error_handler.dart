import 'dart:developer';
import 'dart:io';

import 'package:shared/gen/l10n.dart';
import 'package:shared/src/contract/api_response.dart';
import 'package:shared/src/error/exceptions.dart';
import 'package:shared/src/error/failure.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

/// Handles exceptions and maps them to appropriate [AppFailure].
class ErrorHandler {
  /// Handles errors from the given [operation] and maps them to [AppFailure].
  ///
  /// Returns an [Either] containing either the successful result of type [T]
  /// or an [AppFailure] in case of an error.
  static Future<Either<AppFailure, T>> handle<T>(Future<T> Function() operation) async {
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

      if (error is DioException) {
        return Left(_handleDioError(error, stackTrace));
      }

      final l10n = SharedLocalizations.current;

      if (error is SocketException) {
        return Left(AppFailure.noInternetConnection(l10n.errorNoInternetConnection, stackTrace: stackTrace));
      }

      if (error is FormatException) {
        return Left(AppFailure.dataParsingError(l10n.errorDataParsing, stackTrace: stackTrace));
      }

      if (error is HiveError || error is LocalStorageException) {
        return Left(AppFailure.localStorageError(l10n.errorLocalStorage, stackTrace: stackTrace));
      }

      if (error is Exception) {
        return Left(AppFailure.unidentified(error.toString(), stackTrace: stackTrace));
      }

      return Left(AppFailure.unidentified(l10n.errorUnknown, stackTrace: stackTrace));
    }
  }

  /// Maps a [DioException] to an appropriate [AppFailure].
  ////
  /// Inspects the type of Dio error and constructs a corresponding [AppFailure]
  /// with a localized message.
  static AppFailure _handleDioError(DioException error, StackTrace? stackTrace) {
    final l10n = SharedLocalizations.current;

    // Sometimes Dio wraps the real error (e.g., SocketException) inside DioException.
    if (error.error is SocketException) {
      return AppFailure.noInternetConnection(l10n.errorNoInternetConnection, stackTrace: stackTrace);
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return AppFailure.connectionTimeout(l10n.errorConnectionTimeout, stackTrace: stackTrace);

      case DioExceptionType.sendTimeout:
        return AppFailure.sendTimeout(l10n.errorSendTimeout, stackTrace: stackTrace);

      case DioExceptionType.receiveTimeout:
        return AppFailure.receiveTimeout(l10n.errorReceiveTimeout, stackTrace: stackTrace);

      case DioExceptionType.cancel:
        return AppFailure.cancelled(l10n.errorCancelled, stackTrace: stackTrace);

      case DioExceptionType.connectionError:
        return AppFailure.connectionError(l10n.errorConnectionError, stackTrace: stackTrace);

      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response, stackTrace);

      default:
        return AppFailure.unidentified(l10n.errorUnknown, stackTrace: stackTrace);
    }
  }

  /// Handles bad HTTP responses and extracts meaningful error information.
  ///
  /// Analyzes the [response] to extract status code and error message and constructs
  /// an [AppFailure] with the relevant details.
  static AppFailure _handleBadResponse(Response? response, StackTrace? stackTrace) {
    final statusCode = response?.statusCode ?? HttpStatus.internalServerError;

    final apiResponse = response != null && response.data is Map<String, dynamic>
        ? ApiResponse.fromJson(response.data as Map<String, dynamic>)
        : null;

    var message = apiResponse?.error?.message ?? _getMessageFromStatusCode(statusCode);
    var errorCode = apiResponse?.error?.code ?? '';

    return AppFailure(statusCode: statusCode, errorCode: errorCode, message: message, stackTrace: stackTrace);
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
