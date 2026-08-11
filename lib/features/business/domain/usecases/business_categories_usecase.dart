import 'package:campus_cart/features/business/data/models/business_categories_model.dart';
import 'package:campus_cart/features/business/domain/repositories/business_category_repository.dart';

class BusinessCategoriesUseCase {
  final BusinessCategoryRepository repository;

  BusinessCategoriesUseCase({required this.repository});

  Future<BusinessCategoriesModel> call() async {
    return await repository.getBusinessCategories();
  }
}
