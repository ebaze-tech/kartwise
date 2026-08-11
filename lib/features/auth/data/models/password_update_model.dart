import 'package:campus_cart/features/auth/domain/entities/password_update_entity.dart';

class PasswordUpdateModel extends PasswordUpdateEntity {
  PasswordUpdateModel({required super.message});

  factory PasswordUpdateModel.fromJson(Map<String, dynamic> json) {
    return PasswordUpdateModel(message: json['message']);
  }
}
