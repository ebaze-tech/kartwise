import 'package:campus_cart/features/business/domain/entities/business_entity.dart';

class ProductEntity {
  final String id;
  final String name;
  final String description;
  final String price;
  final bool isAvailable;
  final int stockCount;
  final String businessId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String productCategoryName;
  final List<ProductImages>? images;
  final List<BusinessEntity>? business;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.isAvailable,
    required this.stockCount,
    required this.businessId,
    required this.createdAt,
    required this.updatedAt,
    required this.productCategoryName,
    this.images,
    this.business,
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      isAvailable: json['isAvailable'] as bool,
      stockCount: json['stockCount'] as int,
      businessId: json['businessId'] as String,
      productCategoryName: json['productCategoryName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      images: json['images'] != null
          ? (json['images'] as List<dynamic>)
                .map((item) => ProductImages.fromJson(item))
                .toList()
          : null,
    );
  }
}

class ProductImages {
  final String id;
  final String url;
  final String productId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductImages({
    required this.id,
    required this.url,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductImages.fromJson(Map<String, dynamic> json) {
    return ProductImages(
      id: json['id'] as String,
      url: json['url'] as String,
      productId: json['productId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
