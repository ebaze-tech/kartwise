import 'package:campus_cart/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:campus_cart/features/auth/domain/entities/password_update_entity.dart';

class UpdatePasswordUsecase {
  AuthRemoteDataSource authRemoteDataSource;

  UpdatePasswordUsecase({required this.authRemoteDataSource});

  Future<PasswordUpdateEntity> call(
    String currentPassword,
    String newPassword,
  ) async {
    return await authRemoteDataSource.updatePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
