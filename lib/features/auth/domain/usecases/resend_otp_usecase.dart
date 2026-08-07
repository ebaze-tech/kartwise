import 'package:campus_cart/features/auth/domain/entities/otp_entity.dart';
import 'package:campus_cart/features/auth/domain/repositories/auth_repository.dart';

class ResendOtpUsecase {
  final AuthRepository _authRepository;

  ResendOtpUsecase({required this._authRepository});

  Future<OtpEntity> call() {
    return _authRepository.resendOtp();
  }
}
