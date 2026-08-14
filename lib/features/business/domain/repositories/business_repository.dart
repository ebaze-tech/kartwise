import 'dart:io';
import 'package:campus_cart/features/business/data/models/business_model.dart';
import 'package:campus_cart/features/business/data/models/business_products_model.dart';
import 'package:campus_cart/features/business/data/models/business_categories_model.dart';

abstract class BusinessRepository {
  Future<BusinessModel> createBusiness(
    final String name,
    final String description,
    final String emailAddress,
    final String phoneNumber,
    final String businessCategoryName,
    final String address,
    final File? bannerImage,
    final bool isActive,
  );

  Future<BusinessModel> updateBusiness(
    final String id,
    final String name,
    final String description,
    final String emailAddress,
    final String phoneNumber,
    final String? businessCategoryName,
    final String address,
    final File? bannerImage,
    final bool isActive,
  );

  Future<BusinessProductsModel> getBusinessProducts();

  Future<BusinessProductByIdModel> getBusinessProductById(String productId);

  Future<UpdateProductsModel> updateBusinessProductById(
    bool? isAvailable,
    int? stockCount,
    String productId
  );

  Future<BusinessCategoriesModel> getBusinessCategories();

  Future<BusinessCategoriesModel> getBusinessProductCategories();

  Future<BusinessModel> getBusiness();

  Future<CreateProductsModel> createProduct({
    required String name,
    required String description,
    required double price,
    required int stockCount,
    required bool isAvailable,
    required List<File> images,
    required String businessName,
    required String productCategoryName,
  });
}
