import 'package:campus_cart/features/business/data/datasource/business_remote_data_source.dart';
import 'package:campus_cart/features/business/data/models/business_categories_model.dart';
import 'package:campus_cart/features/business/domain/repositories/business_category_repository.dart';

class BusinessCategoryImpl implements BusinessCategoryRepository {
  final BusinessRemoteDataSource businessRemoteDataSource;

  BusinessCategoryImpl({required this.businessRemoteDataSource});

  @override
  Future<BusinessCategoriesModel> getBusinessCategories() async {
    return await businessRemoteDataSource.getBusinessCategories();
  }
}
