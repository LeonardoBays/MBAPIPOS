import 'package:dio/dio.dart';

import '../../../config/api_schema.dart';
import '../../../data/datasources/remote/http_client.dart';
import 'interceptors/log_interceptor.dart';

class HttpClientImpl implements HttpClient {
  HttpClientImpl() {
    client.interceptors.addAll([
      LogApiInterceptor(),
    ]);
  }

  @override
  Dio client = _initClient();

  static Dio _initClient() {
    return Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        baseUrl: ApiSchema.baseUrl,
      ),
    );
  }
}
