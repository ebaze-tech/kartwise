import 'package:campus_cart/features/auth/domain/entities/login_entity.dart';
import 'package:campus_cart/features/auth/domain/entities/otp_entity.dart';
import 'package:campus_cart/features/auth/domain/entities/registration_entity.dart';

abstract class AuthRepository {
  Future<RegistrationEntity> register(
    String email,
    String password,
    String firstName,
    String lastName,
    String role,
  );
  Future<LoginEntity> login(String email, String password);

  Future<OtpEntity> verifyEmail(String otp);

  Future<OtpEntity> resendOtp();
}
