import 'package:shared/src/config/config.dart';
import 'package:shared/src/injection/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:ua_client_hints/ua_client_hints.dart';

/// Creates Dio HTTP client instances with configuration.
class DioFactory with DioMixin implements Dio {
  DioFactory._() {
    options = BaseOptions(
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    );

    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers.addAll(await userAgentClientHintsHeader());
          return handler.next(options);
        },
      ),
    );

    if (kDebugMode) {
      interceptors.add(
        PrettyDioLogger(
          request: true,
          requestBody: true,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 120,
        ),
      );
    }

    httpClientAdapter = HttpClientAdapter();
  }

  static Dio getInstance() {
    final dio = DioFactory._();
    dio.options.baseUrl = sl<AppConfig>().apiBaseUrl;

    return dio;
  }
}
