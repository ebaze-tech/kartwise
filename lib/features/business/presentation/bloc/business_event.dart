import 'dart:io';

abstract class BusinessEvent {}

class CreateBusinessEvent extends BusinessEvent {
  final String name;
  final String description;
  final String businessCategoryName;
  final String address;
  final String emailAddress;
  final String phoneNumber;
  final File? bannerImage;
  final bool isActive;

  CreateBusinessEvent({
    required this.name,
    required this.description,
    required this.businessCategoryName,
    required this.address,
    required this.emailAddress,
    required this.phoneNumber,
    required this.bannerImage,
    required this.isActive,
  });
}

class UpdateBusinessEvent extends BusinessEvent {
  final String id;
  final String name;
  final String description;
  final String address;
  final String emailAddress;
  final String phoneNumber;
  final File? bannerImage;
  final bool isActive;
  final String? categoryName;

  UpdateBusinessEvent({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.emailAddress,
    required this.phoneNumber,
    required this.bannerImage,
    required this.isActive,
    this.categoryName,
  });
}

class GetLocalBusinessEvent extends BusinessEvent {}

class GetBusinessEvent extends BusinessEvent {}

class CreateProductEvent extends BusinessEvent {
  final String name;
  final String description;
  final double price;
  final int stockCount;
  final List<File> images;
  final bool isAvailable;
  final String productCategoryName;

  CreateProductEvent({
    required this.name,
    required this.description,
    required this.price,
    required this.stockCount,
    required this.images,
    required this.isAvailable,
    required this.productCategoryName,
  });
}

class GetBusinessProductsEvent extends BusinessEvent {}

class GetBusinessProductByIdEvent extends BusinessEvent {
  final String productId;

  GetBusinessProductByIdEvent({required this.productId});
}

class GetBusinessCategoriesEvent extends BusinessEvent {}

class GetBusinessProductCategoriesEvent extends BusinessEvent {}
