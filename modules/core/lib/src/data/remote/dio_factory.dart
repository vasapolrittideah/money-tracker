import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:ua_client_hints/ua_client_hints.dart';

class DioFactory with DioMixin implements Dio {
  DioFactory._() {
    options = BaseOptions(
      responseType: ResponseType.json,
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers.addAll(await userAgentClientHintsHeader());
          handler.next(options);
        },
      ),
    );

    if (kDebugMode) {
      interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 80,
        ),
      );
    }

    httpClientAdapter = HttpClientAdapter();
  }

  static Dio getInstance() => DioFactory._();
}
