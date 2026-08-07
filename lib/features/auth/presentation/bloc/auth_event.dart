abstract class AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String role;

  RegisterEvent({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.role,
  });
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class LogoutEvent extends AuthEvent {}

class OtpEvent extends AuthEvent {
  final String otp;

  OtpEvent({required this.otp});
}

class ResendOtpEvent extends AuthEvent {
  ResendOtpEvent();
}

class CheckAuthStatusEvent extends AuthEvent {}
