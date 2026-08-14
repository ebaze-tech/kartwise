import 'package:campus_cart/features/business/data/models/product_categories_model.dart';
import 'package:campus_cart/features/business/data/models/business_categories_model.dart';
import 'package:campus_cart/features/business/domain/repositories/categories_repository.dart';

class CategoriesUseCase {
  final CategoriesRepository repository;

  CategoriesUseCase({required this.repository});

  Future<BusinessCategoriesModel> getBusinessCategories()async{
    return await repository.getBusinessCategories();
  }

  Future<ProductCategoriesModel> getProductCategories() async {
    return await repository.getProductCategories();
  }
}
