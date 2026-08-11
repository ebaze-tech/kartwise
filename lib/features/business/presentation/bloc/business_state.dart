import 'package:campus_cart/features/business/domain/entities/business_entity.dart';
import 'package:campus_cart/features/business/domain/entities/product_entity.dart';

abstract class BusinessState {}

class BusinessInitial extends BusinessState {}

class BusinessLoading extends BusinessState {}

class BusinessLoaded extends BusinessState {
  final String message;
  final BusinessEntity data;

  BusinessLoaded({required this.message, required this.data});
}

class BusinessUpdateLoading extends BusinessState {}

class BusinessUpdateLoaded extends BusinessState {
  final String message;
  final BusinessEntity data;

  BusinessUpdateLoaded({required this.message, required this.data});
}

class BusinessUpdateError extends BusinessState {
  final String errorMessage;

  BusinessUpdateError({required this.errorMessage});
}

class BusinessError extends BusinessState {
  final String errorMessage;

  BusinessError({required this.errorMessage});
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
  final String businessPhone;

  LocalBusinessLoaded({
    required this.businessId,
    required this.businessName,
    required this.businessEmail,
    required this.businessPhone,
  });
}
