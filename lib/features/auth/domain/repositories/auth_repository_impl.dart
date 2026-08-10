import 'package:campus_cart/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:campus_cart/features/auth/data/models/confirm_email_update_model.dart';
import 'package:campus_cart/features/auth/data/models/email_update_model.dart';
import 'package:campus_cart/features/auth/data/models/user_profile_model.dart';
import 'package:campus_cart/features/auth/domain/entities/login_entity.dart';
import 'package:campus_cart/features/auth/domain/entities/otp_entity.dart';
import 'package:campus_cart/features/auth/domain/entities/registration_entity.dart';
import 'package:campus_cart/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<RegistrationEntity> register(
    String email,
    String password,
    String firstName,
    String lastName,
    String role,
  ) async {
    return await authRemoteDataSource.register(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      role: role,
    );
  }

  @override
  Future<LoginEntity> login(String email, String password) async {
    return await authRemoteDataSource.login(email: email, password: password);
  }

  @override
  Future<OtpEntity> verifyEmail(String otp) async {
    return await authRemoteDataSource.verifyEmail(otp: otp);
  }

  @override
  Future<OtpEntity> resendOtp() async {
    return await authRemoteDataSource.resendOtp();
  }

  @override
  Future<UserProfileModel> getUserProfile() async {
    return await authRemoteDataSource.getUserProfile();
  }

  @override
  Future<UserProfileModel> updateUserProfile(String university) async {
    return await authRemoteDataSource.updateUserProfile(university);
  }

  @override
  Future<EmailUpdateModel> updateEmail(
    String currentEmail,
    String newEmail,
  ) async {
    return await authRemoteDataSource.updateEmail(currentEmail, newEmail);
  }

  @override
  Future<ConfirmEmailUpdateModel> confirmEmailUpdate(String otp) async {
    return await authRemoteDataSource.confirmEmailUpdate(otp);
  }
}
