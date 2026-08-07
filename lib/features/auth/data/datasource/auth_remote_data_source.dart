import 'dart:convert';

import 'package:campus_cart/core/network/dio.dart';
import 'package:campus_cart/features/auth/data/models/login_model.dart';
import 'package:campus_cart/features/auth/data/models/otp_model.dart';
import 'package:campus_cart/features/auth/data/models/registration_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final ApiClient apiClient;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthRemoteDataSource({required this.apiClient});

  Future<RegistrationModel> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String role,
  }) async {
    try {
      final response = await apiClient.dio.post(
        '/accounts/signup',
        data: {
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
          'role': role,
        },
      );
      return RegistrationModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiClient.dio.post(
        '/accounts/signin',
        data: {'email': email, 'password': password},
      );
      return LoginModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<OtpModel> verifyEmail({required String otp}) async {
    final userId = await _storage.read(key: 'userId');
    try {
      final response = await apiClient.dio.post(
        '/accounts/verify-email',
        data: {'userId': userId, 'otp': otp},
      );

      return OtpModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<OtpModel> resendOtp() async {
    final email = await _storage.read(key: 'email');
    try {
      final response = await apiClient.dio.post(
        '/accounts/resend-verification',
        data: {'email': email},
      );
      return OtpModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      final messageData = e.response?.data['message'];
      if (messageData is List) return Exception(messageData.join('\n'));
      return Exception(messageData.toString());
    }
    return Exception('A network error occurred. Please try again.');
  }
}
