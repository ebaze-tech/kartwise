import 'package:campus_cart/features/business/data/models/product_categories_model.dart';
import 'package:campus_cart/features/business/data/models/business_categories_model.dart';
import 'package:campus_cart/features/business/domain/repositories/categories_repository.dart';
import 'package:campus_cart/features/business/data/datasource/categories_remote_data_source.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource categoriesRemoteDataSource;

  CategoriesRepositoryImpl({required this.categoriesRemoteDataSource});

  @override
  Future<BusinessCategoriesModel> getBusinessCategories() async {
    return await categoriesRemoteDataSource.getBusinessCategories();
  }

  @override
  Future<ProductCategoriesModel> getProductCategories() async {
    return await categoriesRemoteDataSource.getProductCategories();
  }
}
