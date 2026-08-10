import 'package:campus_cart/features/business/domain/entities/business_entity.dart';

class BusinessCategoryEntity {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<BusinessEntity>? businesses;

  BusinessCategoryEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.businesses,
  });

  factory BusinessCategoryEntity.fromJson(Map<String, dynamic> json) {
    return BusinessCategoryEntity(
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
    );
  }
}
