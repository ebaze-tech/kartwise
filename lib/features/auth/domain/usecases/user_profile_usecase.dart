import 'package:campus_cart/features/auth/data/models/user_profile_model.dart';
import 'package:campus_cart/features/auth/domain/repositories/auth_repository.dart';

class UserProfileUsecase {
  final AuthRepository authRepository;

  UserProfileUsecase({required this.authRepository});

  Future<UserProfileModel> call() async {
    return await authRepository.getUserProfile();
  }
}
