import 'package:campus_cart/features/business/domain/entities/business_category_entity.dart';
import 'package:campus_cart/features/business/domain/entities/business_entity.dart';
import 'package:campus_cart/features/business/domain/entities/product_entity.dart';

abstract class BusinessState {}

class BusinessInitial extends BusinessState {}

class BusinessLoading extends BusinessState {}

class BusinessLoaded extends BusinessState {
  final String message;
  final BusinessEntity? data;

  BusinessLoaded({required this.message, this.data});
}

class BusinessError extends BusinessState {
  final String errorMessage;

  BusinessError({required this.errorMessage});
}

class BusinessCategoryInitial extends BusinessState {}

class BusinessCategoryLoading extends BusinessState {}

class BusinessCategoryLoaded extends BusinessState {
  final String message;
  final List<BusinessCategoryEntity>? data;

  BusinessCategoryLoaded({required this.message, this.data});
}

class BusinessCategoryError extends BusinessState {
  final String errorMessage;

  BusinessCategoryError({required this.errorMessage});
}

class BusinessProductsInitial extends BusinessState {}

class BusinessProductsLoading extends BusinessState {}

class BusinessProductsLoaded extends BusinessState {
  final String message;
  final List<ProductEntity>? data;

  BusinessProductsLoaded({required this.message, this.data});
}

class BusinessProductsError extends BusinessState {
  final String errorMessage;

  BusinessProductsError({required this.errorMessage});
}

class LocalBusinessLoaded extends BusinessState {
  final String businessId;
  final String businessName;
  final String businessEmail;

  LocalBusinessLoaded({
    required this.businessId,
    required this.businessName,
    required this.businessEmail,
  });
}
