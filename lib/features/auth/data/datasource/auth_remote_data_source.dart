import 'package:dio/dio.dart';
import 'package:campus_cart/core/network/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:campus_cart/features/auth/data/models/otp_model.dart';
import 'package:campus_cart/features/auth/data/models/login_model.dart';
import 'package:campus_cart/features/auth/data/models/email_update_model.dart';
import 'package:campus_cart/features/auth/data/models/registration_model.dart';
import 'package:campus_cart/features/auth/data/models/user_profile_model.dart';
import 'package:campus_cart/features/auth/data/models/password_update_model.dart';
import 'package:campus_cart/features/auth/data/models/confirm_email_update_model.dart';

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
      print(response.data);
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
      print(response.data);
      return LoginModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<PasswordUpdateModel> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await apiClient.dio.patch(
        '/accounts/change-password',
        data: {'currentPassword': currentPassword, 'newPassword': newPassword},
      );
      print(response.data);
      return PasswordUpdateModel.fromJson(response.data);
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

      print(response.data);
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
      print(response.data);
      return OtpModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<UserProfileModel> getUserProfile() async {
    try {
      final response = await apiClient.dio.get('/accounts/me');
      print(response.data);
      return UserProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<UserProfileModel> updateUserProfile(String permanentAddress) async {
    try {
      final response = await apiClient.dio.patch(
        '/accounts/me',
        data: {'permanentAddress': permanentAddress},
      );
      print(response.data);
      return UserProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<EmailUpdateModel> updateEmail(
    String currentEmail,
    String newEmail,
  ) async {
    try {
      final response = await apiClient.dio.patch(
        '/accounts/request-email-update',
        data: {'currentEmail': currentEmail, 'newEmail': newEmail},
      );
      print(response.data);
      return EmailUpdateModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<ConfirmEmailUpdateModel> confirmEmailUpdate(String otp) async {
    try {
      final response = await apiClient.dio.patch(
        '/accounts/confirm-email-update',
        data: {'otp': otp},
      );
      print(response.data);

      return ConfirmEmailUpdateModel.fromJson(response.data);
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
    return Exception('A network error occurred');
  }
}
