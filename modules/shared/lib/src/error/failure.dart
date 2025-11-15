import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

// Local or custom error codes used inside the application only
final class AppErrorCode {
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

  /// Error occurred while accessing local storage data
  static const int localStorageError = 1006;
  static const String localStorageErrorCode = 'LOCAL_STORAGE_ERROR';

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
abstract class AppFailure with _$AppFailure {
  const AppFailure._();

  const factory AppFailure({
    required int statusCode,
    required String errorCode,
    required String message,
    StackTrace? stackTrace,
  }) = _AppFailure;

  factory AppFailure.connectionTimeout(String message, {StackTrace? stackTrace}) => AppFailure(
    statusCode: AppErrorCode.connectionTimeout,
    errorCode: AppErrorCode.connectionTimeoutCode,
    message: message,
    stackTrace: stackTrace,
  );
  factory AppFailure.connectionError(String message, {StackTrace? stackTrace}) => AppFailure(
    statusCode: AppErrorCode.connectionError,
    errorCode: AppErrorCode.connectionErrorCode,
    message: message,
    stackTrace: stackTrace,
  );

  factory AppFailure.receiveTimeout(String message, {StackTrace? stackTrace}) => AppFailure(
    statusCode: AppErrorCode.receiveTimeout,
    errorCode: AppErrorCode.receiveTimeoutCode,
    message: message,
    stackTrace: stackTrace,
  );

  factory AppFailure.sendTimeout(String message, {StackTrace? stackTrace}) => AppFailure(
    statusCode: AppErrorCode.sendTimeout,
    errorCode: AppErrorCode.sendTimeoutCode,
    message: message,
    stackTrace: stackTrace,
  );

  factory AppFailure.cancelled(String message, {StackTrace? stackTrace}) => AppFailure(
    statusCode: AppErrorCode.cancelled,
    errorCode: AppErrorCode.cancelledCode,
    message: message,
    stackTrace: stackTrace,
  );

  factory AppFailure.localStorageError(String message, {StackTrace? stackTrace}) => AppFailure(
    statusCode: AppErrorCode.localStorageError,
    errorCode: AppErrorCode.localStorageErrorCode,
    message: message,
    stackTrace: stackTrace,
  );

  factory AppFailure.noInternetConnection(String message, {StackTrace? stackTrace}) => AppFailure(
    statusCode: AppErrorCode.noInternetConnection,
    errorCode: AppErrorCode.noInternetConnectionCode,
    message: message,
    stackTrace: stackTrace,
  );

  factory AppFailure.dataParsingError(String message, {StackTrace? stackTrace}) => AppFailure(
    statusCode: AppErrorCode.dataParsingError,
    errorCode: AppErrorCode.dataParsingErrorCode,
    message: message,
    stackTrace: stackTrace,
  );

  factory AppFailure.thirdPartyServiceError(String message, {StackTrace? stackTrace}) => AppFailure(
    statusCode: AppErrorCode.thirdPartyServiceError,
    errorCode: AppErrorCode.thirdPartyServiceErrorCode,
    message: message,
    stackTrace: stackTrace,
  );

  factory AppFailure.unidentified(String message, {StackTrace? stackTrace}) => AppFailure(
    statusCode: AppErrorCode.unidentified,
    errorCode: AppErrorCode.unidentifiedCode,
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
