import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/api_constants.dart';
import '../storage/secure_storage.dart';
import 'auth_interceptor.dart';

class _ColoredLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('*** Request ***');
    print('uri: ${options.uri}');
    print('method: ${options.method}');
    print('headers: ${options.headers}');
    if (options.data != null) print('data: ${options.data}');
    print('');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('\x1B[32m*** Response ***\x1B[0m'); // Green
    print('\x1B[32muri: ${response.requestOptions.uri}\x1B[0m');
    print('\x1B[32mstatusCode: ${response.statusCode}\x1B[0m');
    print('\x1B[32mResponse: ${response.data}\x1B[0m');
    print('');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('\x1B[31m*** DioException ***\x1B[0m'); // Red
    print('\x1B[31muri: ${err.requestOptions.uri}\x1B[0m');
    print('\x1B[31mtype: ${err.type}\x1B[0m');
    print('\x1B[31mmessage: ${err.message}\x1B[0m');
    if (err.response != null) {
      print('\x1B[31mstatusCode: ${err.response?.statusCode}\x1B[0m');
      print('\x1B[31mresponse: ${err.response?.data}\x1B[0m');
    }
    print('');
    handler.next(err);
  }
}

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Dio get dio => _dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  final secureStorage = ref.watch(secureStorageProvider);
  dio.interceptors.add(AuthInterceptor(dio, secureStorage));
  dio.interceptors.add(_ColoredLogInterceptor());

  return dio;
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiClient(dio);
});
