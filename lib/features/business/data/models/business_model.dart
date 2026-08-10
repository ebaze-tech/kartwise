import 'package:campus_cart/features/business/domain/entities/business_entity.dart';

class BusinessModel {
  final String message;
  final BusinessEntity? data;
  BusinessModel({required this.message, this.data});

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      message: json['message'] as String,
      data: json['data'] != null
          ? BusinessEntity.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
