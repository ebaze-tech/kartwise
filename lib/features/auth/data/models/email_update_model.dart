import 'package:campus_cart/features/auth/domain/entities/email_update_entity.dart';

class EmailUpdateModel extends EmailUpdateEntity {
  EmailUpdateModel({required super.message});

  factory EmailUpdateModel.fromJson(Map<String, dynamic> json) {
    return EmailUpdateModel(message: json['message']);
  }
}
