import 'package:campus_cart/features/business/domain/entities/product_entity.dart';
import 'package:campus_cart/features/business/domain/entities/business_entity.dart';

class CategoryEntity {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<BusinessEntity>? businesses;
  final List<ProductEntity>? products;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.businesses,
    this.products,
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json) {
    return CategoryEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      businesses: json['businesses'] != null
          ? (json['businesses'] as List<dynamic>)
                .map((item) => BusinessEntity.fromJson(item))
                .toList()
          : null,
      products: json['products'] != null
          ? (json['products'] as List<dynamic>)
                .map((product) => ProductEntity.fromJson(product))
                .toList()
          : null,
    );
  }
}
