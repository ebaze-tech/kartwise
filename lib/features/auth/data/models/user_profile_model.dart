import 'package:campus_cart/features/auth/domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  UserProfileModel({required super.data, required super.message});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      data: json['data'] as Map<String, dynamic>,
      message: json['message'] as String,
    );
  }
}
