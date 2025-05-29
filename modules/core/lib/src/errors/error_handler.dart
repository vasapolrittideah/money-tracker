import 'package:core/core.dart';
import 'package:dio/dio.dart';

class ErrorHandler {
  ErrorHandler._();

  static AppError handle(Exception error) {
    if (error is DioException) {
      final errorMessage = error.response?.data['error_message'];

      switch (error.type) {
        case DioExceptionType.connectionError:
          return NetworkError(message: errorMessage);
        case DioExceptionType.badResponse:
          return ServerError(message: errorMessage);
        case DioExceptionType.cancel:
          return CanceledError(message: errorMessage);
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return TimeoutError(message: errorMessage);
        case DioExceptionType.unknown:
        default:
          return UnknownError(message: errorMessage);
      }
    }

    return UnknownError(message: error.toString());
  }
}
