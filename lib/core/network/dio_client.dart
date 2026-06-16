import 'dart:developer' as developer;

import 'package:dio/dio.dart';

import '../constants/api_constants.dart';

class DioClient {
  const DioClient._();

  static Dio create() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        sendTimeout: ApiConstants.sendTimeout,
        responseType: ResponseType.json,
        headers: const <String, String>{'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: false,
        requestBody: false,
        responseHeader: false,
        responseBody: false,
        error: true,
        logPrint: (Object object) =>
            developer.log(object.toString(), name: 'dio'),
      ),
    );

    return dio;
  }
}
