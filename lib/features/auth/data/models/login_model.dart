import 'package:campus_cart/features/auth/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({
    required super.message,
    required super.accessToken,
    required super.refreshToken,
    required super.role
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      message: json['message'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      role: json['role'] 
    );
  }
}
