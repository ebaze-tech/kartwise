import 'package:campus_cart/features/auth/domain/entities/otp_entity.dart';

class OtpModel extends OtpEntity {
  OtpModel({required super.message});

  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(message: json['message']);
  }
}
