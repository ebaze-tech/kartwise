import 'package:campus_cart/features/auth/data/models/confirm_email_update_model.dart';
import 'package:campus_cart/features/auth/domain/repositories/auth_repository.dart';

class ConfirmEmailUpdateUsecase {
  final AuthRepository authRepository;

  ConfirmEmailUpdateUsecase({required this.authRepository});

  Future<ConfirmEmailUpdateModel> call(String otp) async {
    return authRepository.confirmEmailUpdate(otp);
  }
}
