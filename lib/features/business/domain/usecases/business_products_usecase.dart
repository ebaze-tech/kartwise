import 'package:campus_cart/features/business/data/models/business_products_model.dart';
import 'package:campus_cart/features/business/domain/repositories/business_repository.dart';

class BusinessProductsUsecase {
  final BusinessRepository repository;

  BusinessProductsUsecase({required this.repository});

  Future<BusinessProductsModel> call() async {
    return await repository.getBusinessProducts();
  }
}
