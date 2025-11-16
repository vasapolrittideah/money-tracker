import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

// Local or custom error codes used inside the application only
final class ErrorCode {
  /// Unknown or unhandled error occurred
  static const int unidentified = 1000;
  static const String unidentifiedCode = 'UNIDENTIFIED_ERROR';

  /// Connection attempt timed out before establishing connection
  static const int connectionTimeout = 1001;
  static const String connectionTimeoutCode = 'CONNECTION_TIMEOUT';

  /// Failed to establish connection to the server
  static const int connectionError = 1002;
  static const String connectionErrorCode = 'CONNECTION_ERROR';

  /// Timeout occurred while waiting for server response
  static const int receiveTimeout = 1003;
  static const String receiveTimeoutCode = 'RECEIVE_TIMEOUT';

  /// Timeout occurred while sending request data to server
  static const int sendTimeout = 1004;
  static const String sendTimeoutCode = 'SEND_TIMEOUT';

  /// Request was cancelled before completion
  static const int cancelled = 1005;
  static const String cancelledCode = 'REQUEST_CANCELLED';

  /// Error occurred while accessing cache data
  static const int cacheError = 1006;
  static const String cacheErrorCode = 'CACHE_ERROR';

  /// No internet connection available
  static const int noInternetConnection = 1007;
  static const String noInternetConnectionCode = 'NO_INTERNET_CONNECTION';

  /// Failed to parse response data into expected format
  static const int dataParsingError = 1008;
  static const String dataParsingErrorCode = 'DATA_PARSING_ERROR';

  static const int thirdPartyServiceError = 1009;
  static const String thirdPartyServiceErrorCode = 'THIRD_PARTY_SERVICE_ERROR';
}

/// Represents a failure used throughout the application
@freezed
abstract class Failure with _$Failure {
  const Failure._();

  const factory Failure({
    required int statusCode,
    required String errorCode,
    required String message,
    StackTrace? stackTrace,
  }) = _Failure;

  factory Failure.connectionTimeout(String message, {StackTrace? stackTrace}) => Failure(
    statusCode: ErrorCode.connectionTimeout,
    errorCode: ErrorCode.connectionTimeoutCode,
    message: message,
    stackTrace: stackTrace,
  );
  factory Failure.connectionError(String message, {StackTrace? stackTrace}) => Failure(
    statusCode: ErrorCode.connectionError,
    errorCode: ErrorCode.connectionErrorCode,
    message: message,
    stackTrace: stackTrace,
  );

  factory Failure.receiveTimeout(String message, {StackTrace? stackTrace}) => Failure(
    statusCode: ErrorCode.receiveTimeout,
    errorCode: ErrorCode.receiveTimeoutCode,
    message: message,
    stackTrace: stackTrace,
  );

  factory Failure.sendTimeout(String message, {StackTrace? stackTrace}) => Failure(
    statusCode: ErrorCode.sendTimeout,
    errorCode: ErrorCode.sendTimeoutCode,
    message: message,
    stackTrace: stackTrace,
  );

  factory Failure.cancelled(String message, {StackTrace? stackTrace}) => Failure(
    statusCode: ErrorCode.cancelled,
    errorCode: ErrorCode.cancelledCode,
    message: message,
    stackTrace: stackTrace,
  );

  factory Failure.cacheError(String message, {StackTrace? stackTrace}) => Failure(
    statusCode: ErrorCode.cacheError,
    errorCode: ErrorCode.cacheErrorCode,
    message: message,
    stackTrace: stackTrace,
  );

  factory Failure.noInternetConnection(String message, {StackTrace? stackTrace}) => Failure(
    statusCode: ErrorCode.noInternetConnection,
    errorCode: ErrorCode.noInternetConnectionCode,
    message: message,
    stackTrace: stackTrace,
  );

  factory Failure.dataParsingError(String message, {StackTrace? stackTrace}) => Failure(
    statusCode: ErrorCode.dataParsingError,
    errorCode: ErrorCode.dataParsingErrorCode,
    message: message,
    stackTrace: stackTrace,
  );

  factory Failure.thirdPartyServiceError(String message, {StackTrace? stackTrace}) => Failure(
    statusCode: ErrorCode.thirdPartyServiceError,
    errorCode: ErrorCode.thirdPartyServiceErrorCode,
    message: message,
    stackTrace: stackTrace,
  );

  factory Failure.unidentified(String message, {StackTrace? stackTrace}) => Failure(
    statusCode: ErrorCode.unidentified,
    errorCode: ErrorCode.unidentifiedCode,
    message: message,
    stackTrace: stackTrace,
  );

  /// Checks if this is a network-related error
  ///
  /// Returns `true` for error codes between 1001 and 1007 inclusive
  bool get isNetworkError => statusCode >= 1001 && statusCode <= 1007;

  /// Checks if this is a validation error
  ///
  /// Returns `true` for error codes 400 (Bad Request) and 422 (Unprocessable Entity)
  bool get isValidationError => statusCode == 400 || statusCode == 422;

  /// Checks if this is a server error
  ///
  /// Returns `true` for error codes between 500 and 599 inclusive
  bool get isServerError => statusCode >= 500 && statusCode < 600;
}
