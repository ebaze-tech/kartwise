import 'package:campus_cart/features/business/domain/entities/business_category_entity.dart';

class BusinessCategoriesModel {
  final String message;
  final List<BusinessCategoryEntity>? data;
  BusinessCategoriesModel({required this.message, required this.data});

  factory BusinessCategoriesModel.fromJson(Map<String, dynamic> json) {
    return BusinessCategoriesModel(
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.where((item) => item != null)
          .map(
            (item) =>
                BusinessCategoryEntity.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
