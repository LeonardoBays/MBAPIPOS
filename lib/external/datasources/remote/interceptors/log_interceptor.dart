import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LogApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('Request >>>> ${options.method} ${options.uri}');
      print('Header: ${options.headers}');
      print('Body: ${options.data}');
      print('=====/=====/=====/=====/=====/=====/=====/=====');
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print(
        'Error <<<< ${err.response?.requestOptions.method} '
            '[${err.response?.statusCode}] '
            'URI: ${err.requestOptions.uri}',
      );
      print('Message: ${err.message}');
      print('Type: ${err.type}');
      print('Response: ${err.response}');
      print(
          '=====/=====/=====/=====/=====/=====/=====/=====/=====/=====/=====');
    }
    return super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('Response <<<< ${response.statusCode} '
          '${response.requestOptions.method} ${response.realUri}');
      print('Body: ${response.data}');
      print('=====/=====/=====/=====/=====/=====/=====/=====');
    }
    return super.onResponse(response, handler);
  }
}
