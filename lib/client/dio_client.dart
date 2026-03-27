import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

class DioClient {
  static final Dio _dio =
      Dio(
          BaseOptions(
            baseUrl: dotenv.get('BASE_URL', fallback: 'https://dummyjson.com'),
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              final token = GetStorage().read('token');
              if (token != null) {
                options.headers['Authorization'] = 'Bearer $token';
              }
              return handler.next(options);
            },

            onError: (DioException e, handler) {
              print(e.message);
              return handler.next(e);
            },
          ),
        );

  static Dio get instance => _dio;
}
