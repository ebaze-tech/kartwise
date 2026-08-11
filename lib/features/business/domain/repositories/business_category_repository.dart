import 'package:campus_cart/features/business/data/models/business_categories_model.dart';

abstract class BusinessCategoryRepository {
  Future<BusinessCategoriesModel> getBusinessCategories();
}
