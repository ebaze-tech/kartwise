import 'package:campus_cart/features/business/domain/entities/category_entity.dart';

abstract class BusinessCategoriesState {}

class BusinessCategoriesInitial extends BusinessCategoriesState {}

class BusinessCategoriesLoading extends BusinessCategoriesState {}

class BusinessCategoriesLoaded extends BusinessCategoriesState {
  final String message;
  final List<CategoryEntity>? data;

  BusinessCategoriesLoaded({required this.message, required this.data});
}

class BusinessCategoriesError extends BusinessCategoriesState {
  final String errorMessage;

  BusinessCategoriesError({required this.errorMessage});
}

abstract class ProductCategoriesState {}

class ProductCategoriesInitial extends ProductCategoriesState {}

class ProductCategoriesLoading extends ProductCategoriesState {}

class ProductCategoriesLoaded extends ProductCategoriesState {
  final String message;
  final List<CategoryEntity>? data;

  ProductCategoriesLoaded({required this.message, required this.data});
}

class ProductCategoriesError extends ProductCategoriesState {
  final String errorMessage;

  ProductCategoriesError({required this.errorMessage});
}
