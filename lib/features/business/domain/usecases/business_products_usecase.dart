import 'dart:io';

import 'package:campus_cart/features/business/data/models/business_categories_model.dart';
import 'package:campus_cart/features/business/data/models/business_products_model.dart';
import 'package:campus_cart/features/business/domain/repositories/business_repository.dart';

class BusinessProductsUsecase {
  final BusinessRepository repository;

  BusinessProductsUsecase({required this.repository});

  Future<CreateProductsModel> createProduct({
    required String name,
    required String description,
    required double price,
    required int stockCount,
    required bool isAvailable,
    required String businessName,
    required String productCategoryName,
    required List<File> images,
  }) async {
    return await repository.createProduct(
      name: name,
      description: description,
      price: price,
      stockCount: stockCount,
      isAvailable: isAvailable,
      images: images,
      businessName: businessName,
      productCategoryName: productCategoryName,
    );
  }

  Future<BusinessProductsModel> call() async {
    return await repository.getBusinessProducts();
  }

  Future<BusinessProductByIdModel> getBusinessProductById(String productId) async {
    return await repository.getBusinessProductById(productId);
  }

  Future<BusinessCategoriesModel> getBusinessCategories() async {
    return await repository.getBusinessCategories();
  }

  Future<BusinessCategoriesModel> getBusinessProductCategories() async {
    return await repository.getBusinessProductCategories();
  }
}
