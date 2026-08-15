import 'dart:io';
import 'package:campus_cart/features/business/data/models/business_model.dart';
import 'package:campus_cart/features/business/data/models/business_products_model.dart';
import 'package:campus_cart/features/business/data/models/business_categories_model.dart';
import 'package:campus_cart/features/business/domain/repositories/business_repository.dart';
import 'package:campus_cart/features/business/data/datasource/business_remote_data_source.dart';

class BusinessRepositoryImpl extends BusinessRepository {
  final BusinessRemoteDataSource businessRemoteDataSource;
  BusinessRepositoryImpl({required this.businessRemoteDataSource});

  @override
  Future<BusinessModel> createBusiness(
    String name,
    String description,
    String emailAddress,
    String phoneNumber,
    String businessCategoryName,
    String address,
    File? bannerImage,
    bool isActive,
  ) async {
    return await businessRemoteDataSource.createBusiness(
      name: name,
      description: description,
      emailAddress: emailAddress,
      phoneNumber: phoneNumber,
      address: address,
      bannerImage: bannerImage,
      businessCategoryName: businessCategoryName,
      isActive: isActive,
    );
  }

  @override
  Future<BusinessModel> updateBusiness(
    String id,
    String name,
    String description,
    String emailAddress,
    String phoneNumber,
    String? businessCategoryName,
    String address,
    File? bannerImage,
    bool isActive,
  ) async {
    return await businessRemoteDataSource.updateBusiness(
      id: id,
      name: name,
      description: description,
      emailAddress: emailAddress,
      phoneNumber: phoneNumber,
      address: address,
      bannerImage: bannerImage,
      businessCategoryName: businessCategoryName,
      isActive: isActive,
    );
  }

  @override
  Future<BusinessProductsModel> getBusinessProducts() async {
    return await businessRemoteDataSource.getBusinessProducts();
  }

  @override
  Future<BusinessProductByIdModel> getBusinessProductById(
    String productId,
  ) async {
    return await businessRemoteDataSource.getBusinessProductById(productId);
  }

  @override
  Future<UpdateProductsModel> updateBusinessProductById(
    bool? isAvailable,
    int? stockCount,
    String productId,
  ) async {
    return await businessRemoteDataSource.updateBusinessProductById(
      isAvailable,
      stockCount,
      productId,
    );
  }

  @override
  Future<CreateProductsModel> createProduct({
    required String name,
    required String description,
    required double price,
    required bool isAvailable,
    required int stockCount,
    required List<File> images,
    required String businessName,
    required String productCategoryName,
  }) async {
    return await businessRemoteDataSource.createProduct(
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

  @override
  Future<BusinessCategoriesModel> getBusinessCategories() async {
    return await businessRemoteDataSource.getBusinessCategories();
  }

  @override
  Future<BusinessCategoriesModel> getBusinessProductCategories() async {
    return await businessRemoteDataSource.getBusinessProductCategories();
  }

  @override
  Future<BusinessModel> getBusiness() async {
    return await businessRemoteDataSource.getBusiness();
  }
}
