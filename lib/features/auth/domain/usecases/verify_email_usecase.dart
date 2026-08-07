import 'package:campus_cart/features/auth/domain/entities/otp_entity.dart';
import 'package:campus_cart/features/auth/domain/repositories/auth_repository.dart';

class VerifyEmailUsecase {
  final AuthRepository _authRepository;

  VerifyEmailUsecase({required this._authRepository});

  Future<OtpEntity> call(String otp) {
    return _authRepository.verifyEmail(otp);
  }
}
