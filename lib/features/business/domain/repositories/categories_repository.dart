import 'package:campus_cart/features/business/data/models/product_categories_model.dart';
import 'package:campus_cart/features/business/data/models/business_categories_model.dart';

abstract class CategoriesRepository {
  Future<BusinessCategoriesModel> getBusinessCategories();

  Future<ProductCategoriesModel> getProductCategories();
}
