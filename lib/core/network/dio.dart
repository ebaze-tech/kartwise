import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  late final Dio dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final VoidCallback  onUnauthenticated;

  ApiClient({required this.onUnauthenticated}) {
    dio = Dio(
      BaseOptions(
        baseUrl: dotenv.get('BASE_URL'),
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: 'accessToken');

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode != 401) {
            return handler.next(error);
          }

          final refreshToken = await _storage.read(key: 'refreshToken');

          if (refreshToken == null) {
            await _forceLogout();
            return handler.next(error);
          }

          try {
            final refreshDio = Dio();
            final response = await refreshDio.post(
              '${dotenv.get('BASE_URL')}/accounts/refresh-token',
              data: {'refreshToken': refreshToken},
            );

            final newAccessToken = response.data['accessToken'];
            final newRefreshToken = response.data['refreshToken'];

            await _storage.write(key: 'accessToken', value: newAccessToken);
            await _storage.write(key: 'refreshToken', value: newRefreshToken);

            error.requestOptions.headers['Authorization'] =
                'Bearer $newAccessToken';

            final retryResponse = await dio.fetch(error.requestOptions);
            return handler.resolve(retryResponse);
          } catch (refreshError) {
            await _forceLogout();
            return handler.next(error);
          }
        },
      ),
    );
  }

  Future<void> _forceLogout() async {
    await _storage.deleteAll();
    onUnauthenticated();
  }
}
