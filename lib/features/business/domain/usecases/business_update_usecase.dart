import 'dart:io';

import 'package:campus_cart/features/business/data/models/business_model.dart';
import 'package:campus_cart/features/business/domain/repositories/business_repository.dart';

class BusinessUpdateUsecase {
  BusinessRepository businessRepository;

  BusinessUpdateUsecase({required this.businessRepository});

  Future<BusinessModel> call(
    final String id,
    final String name,
    final String description,
    final String emailAddress,
    final String phoneNumber,
    final String? businessCategoryName,
    final String address,
    final bool isActive,
    final File? bannerImage,
  ) async {
    return await businessRepository.updateBusiness(
      id,
      name,
      description,
      emailAddress,
      phoneNumber,
      businessCategoryName,
      address,
      bannerImage,
      isActive,
    );
  }
}
