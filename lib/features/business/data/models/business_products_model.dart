import 'package:campus_cart/features/business/domain/entities/product_entity.dart';

class BusinessProductsModel {
  final String message;
  final List<ProductEntity>? data;
  BusinessProductsModel({required this.message, required this.data});

  factory BusinessProductsModel.fromJson(Map<String, dynamic> json) {
    return BusinessProductsModel(
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.where((item) => item != null)
          .map((item) => ProductEntity.fromJson(item))
          .toList(),
    );
  }
}
