import 'dart:io';
import 'package:campus_cart/features/business/data/models/business_model.dart';
import 'package:campus_cart/features/business/data/models/business_products_model.dart';

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

  Future<BusinessModel> getBusiness();
}
