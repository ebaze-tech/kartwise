import 'package:campus_cart/features/business/domain/usecases/business_categories_usecase.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_category_event.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessCategoryBloc
    extends Bloc<GetBusinessCategoriesEvent, BusinessCategoryState> {
  final BusinessCategoriesUseCase _getBusinessCategoriesUseCase;

  BusinessCategoryBloc({required this._getBusinessCategoriesUseCase})
    : super(BusinessCategoryInitial()) {
    on<GetBusinessCategoriesEvent>(_onGetBusinessCategories);
  }

  Future<void> _onGetBusinessCategories(
    GetBusinessCategoriesEvent event,
    Emitter<BusinessCategoryState> emit,
  ) async {
    emit(BusinessCategoryLoading());
    try {
      final response = await _getBusinessCategoriesUseCase.call();
      emit(
        BusinessCategoryLoaded(message: response.message, data: response.data),
      );
    } catch (e) {
      emit(BusinessCategoryError(errorMessage: _getCleanErrorMessage(e)));
    }
  }

  String _getCleanErrorMessage(Object e) {
    final errorStr = e.toString();
    if (errorStr.startsWith('Exception: ')) {
      return errorStr.replaceFirst('Exception: ', '');
    }
    return errorStr;
  }
}
