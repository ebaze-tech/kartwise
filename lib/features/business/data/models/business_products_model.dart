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

class BusinessProductByIdModel {
  final String message;
  final ProductEntity data;

  BusinessProductByIdModel({required this.message, required this.data});

  factory BusinessProductByIdModel.fromJson(Map<String, dynamic> json) {
    return BusinessProductByIdModel(
      message: json['message'] as String,
      data: ProductEntity.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class CreateProductsModel {
  final String message;
  final ProductEntity data;

  CreateProductsModel({required this.message, required this.data});

  factory CreateProductsModel.fromJson(Map<String, dynamic> json) {
    return CreateProductsModel(
      message: json['message'] as String,
      data: ProductEntity.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class UpdateProductsModel {
  final String message;

  UpdateProductsModel({required this.message});

  factory UpdateProductsModel.fromJson(Map<String, dynamic> json) {
    return UpdateProductsModel(message: json['message'] as String);
  }
}
