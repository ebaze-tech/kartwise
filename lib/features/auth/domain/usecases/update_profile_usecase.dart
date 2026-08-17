import 'dart:io';

import 'package:campus_cart/features/auth/data/models/user_profile_model.dart';
import 'package:campus_cart/features/auth/domain/repositories/auth_repository.dart';

class UpdateProfileUseCase {
  AuthRepository authRepository;

  UpdateProfileUseCase({required this.authRepository});

  Future<UserProfileModel> call(
    String permanentAddress,
    File? profilePicture,
  ) async {
    return await authRepository.updateUserProfile(
      permanentAddress,
      profilePicture,
    );
  }
}
