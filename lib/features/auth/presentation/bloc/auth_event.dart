import 'dart:io';

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

class UserProfileEvent extends AuthEvent {}

class UpdateUserProfileEvent extends AuthEvent {
  final String permanentAddress;
  final File? profilePicture;

  UpdateUserProfileEvent({required this.permanentAddress, this.profilePicture});
}

class CheckAuthStatusEvent extends AuthEvent {}

class RequestEmailUpdateEvent extends AuthEvent {
  final String currentEmail;
  final String newEmail;

  RequestEmailUpdateEvent({required this.currentEmail, required this.newEmail});
}

class ConfirmEmailUpdateEvent extends AuthEvent {
  final String otp;

  ConfirmEmailUpdateEvent({required this.otp});
}

class UpdateUserAvatarEvent extends AuthEvent {
  final File profilePicture;

  UpdateUserAvatarEvent({required this.profilePicture});
}

class UpdatePasswordEvent extends AuthEvent {
  final String currentPassword;
  final String newPassword;

  UpdatePasswordEvent({
    required this.currentPassword,
    required this.newPassword,
  });
}
