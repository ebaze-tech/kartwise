import 'dart:io';

import 'package:campus_cart/features/business/data/models/business_model.dart';
import 'package:campus_cart/features/business/domain/repositories/business_repository.dart';

class BusinessRegistrationUseCase {
  final BusinessRepository repository;

  BusinessRegistrationUseCase({required this.repository});

  Future<BusinessModel> call(
    final String name,
    final String description,
    final String emailAddress,
    final String phoneNumber,
    final String businessCategoryName,
    final String address,
    final File? bannerImage,
    final bool isActive
  ) async {
    return await repository.createBusiness(
      name,
      description,
      emailAddress,
      phoneNumber,
      businessCategoryName,
      address,
      bannerImage,
      isActive
    );
  }
}
