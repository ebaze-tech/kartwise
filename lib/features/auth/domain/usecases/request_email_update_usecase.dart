import 'package:campus_cart/features/auth/data/models/email_update_model.dart';
import 'package:campus_cart/features/auth/domain/repositories/auth_repository.dart';

class RequestEmailUpdateUsecase {
  final AuthRepository authRepository;

  RequestEmailUpdateUsecase({required this.authRepository});

  Future<EmailUpdateModel> call(String currentEmail, String newEmail) async {
    return await authRepository.updateEmail(currentEmail, newEmail);
  }
}
