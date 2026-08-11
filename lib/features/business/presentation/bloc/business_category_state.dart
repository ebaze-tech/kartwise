import 'package:campus_cart/features/business/domain/entities/business_category_entity.dart';

abstract class BusinessCategoryState {}

class BusinessCategoryInitial extends BusinessCategoryState {}

class BusinessCategoryLoading extends BusinessCategoryState {}

class BusinessCategoryLoaded extends BusinessCategoryState {
  final String message;
  final List<BusinessCategoryEntity>? data;

  BusinessCategoryLoaded({required this.message, this.data});
}

class BusinessCategoryError extends BusinessCategoryState {
  final String errorMessage;

  BusinessCategoryError({required this.errorMessage});
}
