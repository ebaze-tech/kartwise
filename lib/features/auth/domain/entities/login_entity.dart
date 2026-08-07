class LoginEntity {
  final String message;
  final String accessToken;
  final String refreshToken;
  final String role;

  LoginEntity({
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.role,
  });
}
