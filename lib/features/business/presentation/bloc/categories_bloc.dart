import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_cart/features/business/domain/usecases/categories_usecase.dart';
import 'package:campus_cart/features/business/presentation/bloc/categories_state.dart';
import 'package:campus_cart/features/business/presentation/bloc/categories_event.dart';

class BusinessCategoriesBloc
    extends Bloc<GetBusinessCategoriesEvent, BusinessCategoriesState> {
  final CategoriesUseCase _categoriesUseCase;

  BusinessCategoriesBloc({required this._categoriesUseCase})
    : super(BusinessCategoriesInitial()) {
    on<GetBusinessCategoriesEvent>(_onGetBusinessCategories);
  }

  Future<void> _onGetBusinessCategories(
    GetBusinessCategoriesEvent event,
    Emitter<BusinessCategoriesState> emit,
  ) async {
    try {
      emit(BusinessCategoriesLoading());
      final response = await _categoriesUseCase.getBusinessCategories();
      // print(response.data);

      emit(
        BusinessCategoriesLoaded(
          message: response.message,
          data: response.data,
        ),
      );
    } catch (e) {
      emit(BusinessCategoriesError(errorMessage: e.toString()));
    }
  }
}

class ProductCategoriesBloc
    extends Bloc<GetProductCategoriesEvent, ProductCategoriesState> {
  final CategoriesUseCase _categoriesUseCase;
  ProductCategoriesBloc({required this._categoriesUseCase})
    : super(ProductCategoriesInitial()) {
    on<GetProductCategoriesEvent>(_onGetProductCategories);
  }

  Future<void> _onGetProductCategories(
    GetProductCategoriesEvent event,
    Emitter<ProductCategoriesState> emit,
  ) async {
    emit(ProductCategoriesLoading());
    try {
      final response = await _categoriesUseCase.getProductCategories();
      // print(response.data);
      emit(
        ProductCategoriesLoaded(message: response.message, data: response.data),
      );
    } catch (e) {
      emit(ProductCategoriesError(errorMessage: e.toString()));
    }
  }
}
