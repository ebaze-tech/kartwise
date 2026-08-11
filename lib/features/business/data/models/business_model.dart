import 'package:campus_cart/features/business/domain/entities/business_entity.dart';

class BusinessModel {
  final String message;
  final BusinessEntity data;
  BusinessModel({required this.message, required this.data});

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      message: json['message'] as String,
      data: BusinessEntity.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}
