import 'package:equatable/equatable.dart';

// Local or custom status code used inside the application only
final class AppErrorCode {
  /// Unknown or unhandled error occurred
  static const int unidentified = 1000;

  /// Connection attempt timed out before establishing connection
  static const int connectionTimeout = 1001;

  /// Failed to establish connection to the server
  static const int connectionError = 1002;

  /// Timeout occurred while waiting for server response
  static const int receiveTimeout = 1003;

  /// Timeout occurred while sending request data to server
  static const int sendTimeout = 1004;

  /// Request was cancelled before completion
  static const int cancelled = 1005;

  /// Error occurred while accessing local storage data
  static const int localStorageError = 1006;

  /// No internet connection available
  static const int noInternetConnection = 1007;

  /// Failed to parse response data into expected format
  static const int dataParsingError = 1008;
}

/// Represents a failure used throughout the application
class AppFailure extends Equatable {
  const AppFailure(this.code, this.message, {this.stackTrace});

  final int code;
  final String message;
  final StackTrace? stackTrace;

  factory AppFailure.connectionTimeout(String message, {StackTrace? stackTrace}) =>
      AppFailure(AppErrorCode.connectionTimeout, message, stackTrace: stackTrace);

  factory AppFailure.connectionError(String message, {StackTrace? stackTrace}) =>
      AppFailure(AppErrorCode.connectionError, message, stackTrace: stackTrace);

  factory AppFailure.receiveTimeout(String message, {StackTrace? stackTrace}) =>
      AppFailure(AppErrorCode.receiveTimeout, message, stackTrace: stackTrace);

  factory AppFailure.sendTimeout(String message, {StackTrace? stackTrace}) =>
      AppFailure(AppErrorCode.sendTimeout, message, stackTrace: stackTrace);

  factory AppFailure.cancelled(String message, {StackTrace? stackTrace}) =>
      AppFailure(AppErrorCode.cancelled, message, stackTrace: stackTrace);

  factory AppFailure.localStorageError(String message, {StackTrace? stackTrace}) =>
      AppFailure(AppErrorCode.localStorageError, message, stackTrace: stackTrace);

  factory AppFailure.noInternetConnection(String message, {StackTrace? stackTrace}) =>
      AppFailure(AppErrorCode.noInternetConnection, message, stackTrace: stackTrace);

  factory AppFailure.dataParsingError(String message, {StackTrace? stackTrace}) =>
      AppFailure(AppErrorCode.dataParsingError, message, stackTrace: stackTrace);

  factory AppFailure.unidentified(String message, {StackTrace? stackTrace}) =>
      AppFailure(AppErrorCode.unidentified, message, stackTrace: stackTrace);

  /// Checks if this is a network-related error
  ///
  /// Returns `true` for error codes between 1001 and 1007 inclusive
  bool get isNetworkError => code >= 1001 && code <= 1007;

  /// Checks if this is a validation error
  ///
  /// Returns `true` for error codes 400 (Bad Request) and 422 (Unprocessable Entity)
  bool get isValidationError => code == 400 || code == 422;

  /// Checks if this is a server error
  ///
  /// Returns `true` for error codes between 500 and 599 inclusive
  bool get isServerError => code >= 500 && code < 600;

  @override
  String toString() {
    return 'AppFailure{code: $code, message: $message, stackTrace: $stackTrace}';
  }

  @override
  List<Object?> get props => [code, message, stackTrace];
}
