import 'package:core/core.dart';
import 'package:dio/dio.dart';

final class ErrorHandlerUtil {
  static Failure handleError(Exception error) {
    if (error is DioException) {
      return switch (error.type) {
        DioExceptionType.connectionError => NetworkFailure(
          message: 'ไม่สามารถเชื่อมต่อกับเซิฟเวอร์ได้',
        ),
        DioExceptionType.cancel => CanceledFailure(
          message: 'ถูกยกเลิกการเชื่อมต่อกับเซิฟเวอร์',
        ),
        DioExceptionType.connectionTimeout => TimeoutFailure(
          message: 'หมดเวลาการเชื่อมต่อกับเซิฟเวอร์',
        ),
        DioExceptionType.receiveTimeout => TimeoutFailure(
          message: 'หมดเวลาการรับข้อมูลจากเซิฟเวอร์',
        ),
        DioExceptionType.sendTimeout => TimeoutFailure(
          message: 'หมดเวลาการส่งข้อมูลไปยังเซิฟเวอร์',
        ),
        DioExceptionType.badResponse => ServerFailure(
          message: error.response!.data['error_message'],
          code: error.response!.data['error_code'],
        ),
        _ => UnknownFailure(message: error.toString()),
      };
    }

    return UnknownFailure(message: error.toString());
  }
}
