import 'package:campus_cart/features/auth/domain/entities/registration_entity.dart';
import 'package:campus_cart/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository _authRepository;

  RegisterUsecase({required this._authRepository});

  Future<RegistrationEntity> call(
    String email,
    String password,
    String firstName,
    String lastName,
    String role,
  ) {
    return _authRepository.register(
      email,
      password,
      firstName,
      lastName,
      role,
    );
  }
}
