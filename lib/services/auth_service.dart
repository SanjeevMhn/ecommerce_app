import 'package:dio/dio.dart';
import 'package:ecommerce_app/client/dio_client.dart';
import 'package:ecommerce_app/mixins/api_handler.dart';
import 'package:get_storage/get_storage.dart';

class AuthService with ApiHandler {
  final _box = GetStorage();

  final Dio _dio = DioClient.instance;

  Future<bool> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'username': username, 'password': password},
        options: Options(extra: {'withCredentials': true}),
      );
      final data = await response.data;
      _box.write('token', data['accessToken']);
      final profileData = await me();
      return profileData;
    } on DioException catch (e) {
      throw handleError(e);
    }
  }

  Future<bool> me() async {
    try {
      final response = await _dio.get('/auth/me');
      final data = await response.data;
      _box.write('user', data);
      return true;
    } on DioException catch (e) {
      throw handleError(e);
    }
  }
}
