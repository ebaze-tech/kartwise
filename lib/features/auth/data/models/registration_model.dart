import 'package:campus_cart/features/auth/domain/entities/registration_entity.dart';

class RegistrationModel extends RegistrationEntity {
  RegistrationModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.role,
    required super.message,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) {
    return RegistrationModel(
      id: json['data']['id'],
      email: json['data']['email'],
      firstName: json['data']['firstName'],
      lastName: json['data']['lastName'],
      role: json['data']['role'],
      message: json['message'],
    );
  }
}
