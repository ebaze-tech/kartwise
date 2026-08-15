import 'package:campus_cart/features/business/domain/entities/product_entity.dart';
import 'package:campus_cart/features/business/domain/entities/business_entity.dart';

abstract class BusinessState {}

class BusinessInitial extends BusinessState {}

class BusinessLoading extends BusinessState {}

class BusinessLoaded extends BusinessState {
  final String message;
  final List<BusinessEntity> data;

  BusinessLoaded({required this.message, required this.data});
}

class BusinessError extends BusinessState {
  final String errorMessage;

  BusinessError({required this.errorMessage});
}

class BusinessUpdateLoading extends BusinessState {}

class BusinessUpdateLoaded extends BusinessState {
  final String message;
  final List<BusinessEntity> data;

  BusinessUpdateLoaded({required this.message, required this.data});
}

class BusinessUpdateError extends BusinessState {
  final String errorMessage;

  BusinessUpdateError({required this.errorMessage});
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

class BusinessProductByIdLoading extends BusinessState {}

class BusinessProductByIdLoaded extends BusinessState {
  final String message;
  final ProductEntity data;

  BusinessProductByIdLoaded({required this.message, required this.data});
}

class BusinessProductByIdError extends BusinessState {
  final String errorMessage;

  BusinessProductByIdError({required this.errorMessage});
}

class UpdateBusinessProductByIdLoading extends BusinessState {}

class UpdateBusinessProductByIdLoaded extends BusinessState {
  final String message;

  UpdateBusinessProductByIdLoaded({required this.message});
}

class UpdateBusinessProductByIdError extends BusinessState {
  final String errorMessage;

  UpdateBusinessProductByIdError({required this.errorMessage});
}

class LocalBusinessLoaded extends BusinessState {
  final String businessId;
  final String businessName;
  final String businessEmail;
  final String businessPhone;

  LocalBusinessLoaded({
    required this.businessId,
    required this.businessName,
    required this.businessEmail,
    required this.businessPhone,
  });
}

class CreateProductLoading extends BusinessState {}

class CreateProductLoaded extends BusinessState {
  final String message;
  final ProductEntity data;

  CreateProductLoaded({required this.message, required this.data});
}

class CreateProductError extends BusinessState {
  final String errorMessage;

  CreateProductError({required this.errorMessage});
}
