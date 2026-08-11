import 'dart:io';

import 'package:campus_cart/features/business/data/datasource/business_remote_data_source.dart';
import 'package:campus_cart/features/business/data/models/business_model.dart';
import 'package:campus_cart/features/business/data/models/business_products_model.dart';
import 'package:campus_cart/features/business/domain/repositories/business_repository.dart';

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
  Future<BusinessModel> getBusiness() async {
    return await businessRemoteDataSource.getBusiness();
  }
}
