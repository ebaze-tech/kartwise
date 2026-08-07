import 'package:campus_cart/features/auth/domain/entities/login_entity.dart';
import 'package:campus_cart/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  Future<LoginEntity> call(String email, String password) async {
    return authRepository.login(email, password);
  }
}
