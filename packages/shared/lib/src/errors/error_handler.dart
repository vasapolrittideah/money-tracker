import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared/generated/locale_keys.g.dart';
import 'package:shared/src/contract/api_response.dart';
import 'package:shared/src/errors/exceptions.dart';
import 'package:shared/src/errors/failure.dart';
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

      if (error is SocketException) {
        return Left(
          Failure.noInternetConnection(SharedLocaleKeys.error_noInternetConnection.tr(), stackTrace: stackTrace),
        );
      }

      if (error is FormatException) {
        return Left(Failure.dataParsingError(SharedLocaleKeys.error_dataParsing.tr(), stackTrace: stackTrace));
      }

      if (error is HiveError || error is CacheException) {
        return Left(Failure.cacheError(SharedLocaleKeys.error_cache.tr(), stackTrace: stackTrace));
      }

      return Left(Failure.unidentified(SharedLocaleKeys.error_unknown.tr(), stackTrace: stackTrace));
    }
  }

  /// Maps a [DioException] to an appropriate [Failure].
  ////
  /// Inspects the type of Dio error and constructs a corresponding [Failure]
  /// with a localized message.
  static Failure _handleDioError(DioException error, StackTrace? stackTrace) {
    // Sometimes Dio wraps the real error (e.g., SocketException) inside DioException.
    if (error.error is SocketException) {
      return Failure.noInternetConnection(SharedLocaleKeys.error_noInternetConnection.tr(), stackTrace: stackTrace);
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Failure.connectionTimeout(SharedLocaleKeys.error_connectionTimeout.tr(), stackTrace: stackTrace);

      case DioExceptionType.sendTimeout:
        return Failure.sendTimeout(SharedLocaleKeys.error_sendTimeout.tr(), stackTrace: stackTrace);

      case DioExceptionType.receiveTimeout:
        return Failure.receiveTimeout(SharedLocaleKeys.error_receiveTimeout.tr(), stackTrace: stackTrace);

      case DioExceptionType.cancel:
        return Failure.cancelled(SharedLocaleKeys.error_cancelled.tr(), stackTrace: stackTrace);

      case DioExceptionType.connectionError:
        return Failure.connectionError(SharedLocaleKeys.error_connectionError.tr(), stackTrace: stackTrace);

      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response, stackTrace);

      default:
        return Failure.unidentified(SharedLocaleKeys.error_unknown.tr(), stackTrace: stackTrace);
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
    return switch (statusCode) {
      HttpStatus.badRequest => SharedLocaleKeys.error_badRequest.tr(),
      HttpStatus.unauthorized => SharedLocaleKeys.error_unauthorized.tr(),
      HttpStatus.forbidden => SharedLocaleKeys.error_forbidden.tr(),
      HttpStatus.notFound => SharedLocaleKeys.error_notFound.tr(),
      HttpStatus.conflict => SharedLocaleKeys.error_conflict.tr(),
      HttpStatus.unprocessableEntity => SharedLocaleKeys.error_unprocessable.tr(),
      HttpStatus.tooManyRequests => SharedLocaleKeys.error_tooManyRequests.tr(),
      HttpStatus.internalServerError => SharedLocaleKeys.error_internalServer.tr(),
      HttpStatus.serviceUnavailable => SharedLocaleKeys.error_serviceUnavailable.tr(),
      HttpStatus.badGateway => SharedLocaleKeys.error_badGateway.tr(),
      HttpStatus.gatewayTimeout => SharedLocaleKeys.error_gatewayTimeout.tr(),
      _ => SharedLocaleKeys.error_unknownCode.tr(args: [statusCode.toString()]),
    };
  }
}
