import 'package:campus_cart/features/business/domain/entities/business_entity.dart';

class BusinessModel {
  final String message;
  final List<BusinessEntity> data;

  BusinessModel({required this.message, required this.data});

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    List<BusinessEntity> parsedData = [];

    if (json['data'] is List) {
      parsedData = (json['data'] as List)
          .map((item) => BusinessEntity.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (json['data'] is Map) {
      parsedData = [
        BusinessEntity.fromJson(json['data'] as Map<String, dynamic>),
      ];
    }

    return BusinessModel(
      message: json['message'] as String? ?? '',
      data: parsedData,
    );
  }
}
