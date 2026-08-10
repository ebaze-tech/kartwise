import 'package:campus_cart/features/auth/domain/entities/email_update_entity.dart';

class ConfirmEmailUpdateModel extends EmailUpdateEntity {
  ConfirmEmailUpdateModel({required super.message});

  factory ConfirmEmailUpdateModel.fromJson(Map<String, dynamic> json) {
    return ConfirmEmailUpdateModel(message: json['message']);
  }
}
