import 'package:campus_cart/features/business/data/models/business_model.dart';
import 'package:campus_cart/features/business/domain/repositories/business_repository.dart';

class BusinessUseCase {
  final BusinessRepository repository;

  BusinessUseCase({required this.repository});

  Future<BusinessModel> call() async {
    return await repository.getBusiness();
  }
}
