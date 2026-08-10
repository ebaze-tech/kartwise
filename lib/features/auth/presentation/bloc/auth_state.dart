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

class RequestEmailUpdateLoading extends AuthState {}

class RequestEmailUpdateSuccess extends AuthState {
  final String message;

  RequestEmailUpdateSuccess({required this.message});
}

class RequestEmailUpdateError extends AuthState {
  final String errorMessage;

  RequestEmailUpdateError({required this.errorMessage});
}

class ConfirmEmailUpdateLoading extends AuthState {}

class ConfirmEmailUpdateSuccess extends AuthState {
  final String message;

  ConfirmEmailUpdateSuccess({required this.message});
}

class ConfirmEmailUpdateError extends AuthState {
  final String errorMessage;

  ConfirmEmailUpdateError({required this.errorMessage});
}

class UpdateUniversityLoading extends AuthState {}

class UpdateUniversitySuccess extends AuthState {
  final String message;
  final Map<String, dynamic> data;

  UpdateUniversitySuccess({required this.message, required this.data});
}

class UpdateUniversityError extends AuthState {
  final String errorMessage;

  UpdateUniversityError({required this.errorMessage});
}
