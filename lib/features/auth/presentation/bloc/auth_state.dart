import 'package:campus_cart/features/auth/data/models/user_profile_model.dart';
import 'package:campus_cart/features/auth/domain/entities/user_profile_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;
  final String? role;
  final String? accessToken;
  final Map<String, dynamic>? userProfile;

  AuthSuccess({
    required this.message,
    this.role,
    this.accessToken,
    this.userProfile,
  });
}

class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure({required this.errorMessage});
}

class UserProfileLoading extends AuthState {}

class UserProfileLoaded extends AuthState {
  final String message;
  final Map<String, dynamic> data;

  UserProfileLoaded({required this.data, required this.message});
}

class UserProfileError extends AuthState {
  final String errorMessage;

  UserProfileError({required this.errorMessage});
}
