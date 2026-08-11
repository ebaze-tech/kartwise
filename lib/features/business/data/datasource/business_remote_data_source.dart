import 'dart:io';

import 'package:campus_cart/core/network/dio.dart';
import 'package:campus_cart/features/business/data/models/business_categories_model.dart';
import 'package:campus_cart/features/business/data/models/business_model.dart';
import 'package:campus_cart/features/business/data/models/business_products_model.dart';
import 'package:dio/dio.dart';

class BusinessRemoteDataSource {
  final ApiClient apiClient;

  BusinessRemoteDataSource({required this.apiClient});

  Future<BusinessModel> createBusiness({
    required String name,
    required String description,
    required String emailAddress,
    required String phoneNumber,
    required String businessCategoryName,
    required String address,
    File? bannerImage,
    required bool isActive,
  }) async {
    try {
      Map<String, dynamic> formDataMap = {
        'name': name,
        'description': description,
        'emailAddress': emailAddress,
        'phoneNumber': phoneNumber,
        'businessCategory': businessCategoryName,
        'address': address,
        'isActive': isActive,
      };
      print(formDataMap);

      if (bannerImage != null) {
        formDataMap['bannerImage'] = await MultipartFile.fromFile(
          bannerImage.path,
          filename: bannerImage.path.split('/').last,
        );
      }

      FormData formData = FormData.fromMap(formDataMap);

      final response = await apiClient.dio.post(
        '/business/setup',
        data: formData,
      );
      print(response.data);
      return BusinessModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<BusinessModel> updateBusiness({
    required String id,
    required String name,
    required String description,
    required String emailAddress,
    required String phoneNumber,
    String? businessCategoryName,
    required String address,
    File? bannerImage,
    required bool isActive,
  }) async {
    try {
      Map<String, dynamic> formDataMap = {
        'name': name,
        'description': description,
        'emailAddress': emailAddress,
        'phoneNumber': phoneNumber,
        'businessCategory': businessCategoryName,
        'address': address,
        'isActive': isActive,
      };
      print(formDataMap);

      if (bannerImage != null) {
        formDataMap['bannerImage'] = await MultipartFile.fromFile(
          bannerImage.path,
          filename: bannerImage.path.split('/').last,
        );
      }

      FormData formData = FormData.fromMap(formDataMap);

      final response = await apiClient.dio.patch(
        '/business/update/$id',
        data: formData,
      );
      print(response.data);
      return BusinessModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<BusinessModel> getBusiness() async {
    try {
      final response = await apiClient.dio.get('/business/me');
      print(response.data);
      Map<String, dynamic> responseData = Map.from(response.data);

      if (responseData['data'] is List) {
        final List dataList = responseData['data'] as List;

        if (dataList.isEmpty) {
          throw Exception('No business data found.');
        }

        responseData['data'] = dataList[0];
      }
      return BusinessModel.fromJson(responseData);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<BusinessCategoriesModel> getBusinessCategories() async {
    try {
      final response = await apiClient.dio.get('/business/categories');
      print(response.data);
      if (response.data == null) {
        throw Exception('Server returned an empty response.');
      }

      final Map<String, dynamic> responseMap =
          response.data as Map<String, dynamic>;

      return BusinessCategoriesModel.fromJson(responseMap);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<BusinessProductsModel> getBusinessProducts() async {
    try {
      final response = await apiClient.dio.get('/business/products');
      print(response.data);
      return BusinessProductsModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch business products.');
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      final messageData = e.response?.data['message'];
      if (messageData is List) return Exception(messageData.join('\n'));
      return Exception(messageData.toString());
    }
    return Exception('A network error occurred. Please try again.');
  }
}
