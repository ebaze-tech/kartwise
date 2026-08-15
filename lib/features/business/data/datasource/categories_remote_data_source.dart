import 'package:dio/dio.dart';
import 'package:campus_cart/core/network/dio.dart';
import 'package:campus_cart/features/business/data/models/product_categories_model.dart';
import 'package:campus_cart/features/business/data/models/business_categories_model.dart';

class CategoriesRemoteDataSource {
  final ApiClient apiClient;

  CategoriesRemoteDataSource({required this.apiClient});

  Future<BusinessCategoriesModel> getBusinessCategories() async {
    try {
      final response = await apiClient.dio.get('/business/categories');
      // print(response.data);
      return BusinessCategoriesModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<ProductCategoriesModel> getProductCategories() async {
    try {
      final resposne = await apiClient.dio.get('/business/products/categories');
      // print(resposne.data);
      return ProductCategoriesModel.fromJson(resposne.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      final messageData = e.response?.data['message'];
      if (messageData is List) return Exception(messageData.join('\n'));
      return Exception(messageData.toString());
    }
    return Exception('A network error occurred');
  }
}
