import 'package:campus_cart/features/business/domain/entities/business_category_entity.dart';
import 'package:campus_cart/features/business/domain/entities/product_entity.dart';

class BusinessEntity {
  final String id;
  final String name;
  final String description;
  final String address;
  final String emailAddress;
  final String phoneNumber;
  final String? bannerImageUrl;
  final bool isActive;
  final String categoryName;
  final BusinessCategoryEntity? category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ProductEntity>? products;

  BusinessEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.emailAddress,
    required this.phoneNumber,
    this.bannerImageUrl,
    required this.isActive,
    required this.categoryName,
    this.category,
    required this.createdAt,
    required this.updatedAt,
    this.products,
  });

  factory BusinessEntity.fromJson(Map<String, dynamic> json) {
    return BusinessEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      emailAddress: json['emailAddress'] as String,
      phoneNumber: json['phoneNumber'] as String,
      bannerImageUrl: json['bannerImageUrl'] as String?,
      isActive: json['isActive'] as bool,
      categoryName: json['categoryName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      category: json['category'] != null
          ? BusinessCategoryEntity.fromJson(
              json['category'] as Map<String, dynamic>,
            )
          : null,
      products: json['products'] != null
          ? (json['products'] as List<dynamic>)
                .map((item) => ProductEntity.fromJson(item))
                .toList()
          : null,
    );
  }
}
