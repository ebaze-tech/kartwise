import 'package:campus_cart/features/business/domain/usecases/business_categories_usecase.dart';
import 'package:campus_cart/features/business/domain/usecases/business_products_usecase.dart';
import 'package:campus_cart/features/business/domain/usecases/business_registration_usecase.dart';
import 'package:campus_cart/features/business/domain/usecases/business_usecase.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_event.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BusinessBloc extends Bloc<BusinessEvent, BusinessState> {
  final BusinessRegistrationUseCase _businessRegistrationUseCase;
  final BusinessCategoriesUseCase _getBusinessCategoriesUseCase;
  final BusinessProductsUsecase _getBusinessProductsUseCase;
  final BusinessUseCase _getBusinessUseCase;
  final _storage = FlutterSecureStorage();

  BusinessBloc({
    required this._businessRegistrationUseCase,
    required this._getBusinessCategoriesUseCase,
    required this._getBusinessProductsUseCase,
    required this._getBusinessUseCase,
  }) : super(BusinessInitial()) {
    on<CreateBusinessEvent>(_onCreateBusiness);
    on<GetBusinessCategoriesEvent>(_onGetBusinessCategories);
    on<GetLocalBusinessEvent>(_onGetLocalBusiness);
    on<GetBusinessProductsEvent>(_onGetBusinessProducts);
    on<GetBusinessEvent>(_onGetBusiness);
  }

  Future<void> _onCreateBusiness(
    CreateBusinessEvent event,
    Emitter<BusinessState> emit,
  ) async {
    emit(BusinessLoading());
    try {
      final response = await _businessRegistrationUseCase.call(
        event.name,
        event.description,
        event.emailAddress,
        event.phoneNumber,
        event.businessCategoryName,
        event.address,
        event.bannerImage,
        event.isActive,
      );
      await _storage.write(key: 'businessId', value: response.data?.id);
      await _storage.write(key: 'businessName', value: response.data?.name);
      await _storage.write(
        key: 'businessEmail',
        value: response.data?.emailAddress,
      );
      await _storage.write(
        key: 'businessPhone',
        value: response.data?.phoneNumber,
      );
      emit(BusinessLoaded(message: response.message, data: response.data));
    } catch (e) {
      emit(BusinessError(errorMessage: _getCleanErrorMessage(e)));
    }
  }

  Future<void> _onGetBusiness(
    GetBusinessEvent event,
    Emitter<BusinessState> emit,
  ) async {
    emit(BusinessLoading());
    try {
      final response = await _getBusinessUseCase.call();
      if (response .data != null) {
        await _storage.write(key: 'businessId', value: response.data!.id);
        await _storage.write(key: 'businessName', value: response.data!.name);
        await _storage.write(
          key: 'businessEmail',
          value: response.data!.emailAddress,
        );
      }
      emit(BusinessLoaded(message: response.message, data: response.data));
    } catch (e) {
      emit(BusinessError(errorMessage: _getCleanErrorMessage(e)));
    }
  }

  Future<void> _onGetLocalBusiness(
    GetLocalBusinessEvent event,
    Emitter<BusinessState> emit,
  ) async {
    emit(BusinessLoading());
    try {
      final businessId = await _storage.read(key: 'businessId');
      final businessName = await _storage.read(key: 'businessName');
      final businessEmail = await _storage.read(key: 'businessEmail');

      print(
        'Local Business Data: ID=$businessId, Name=$businessName, Email=$businessEmail',
      );

      if (businessId != null && businessName != null && businessEmail != null) {
        emit(
          LocalBusinessLoaded(
            businessId: businessId,
            businessName: businessName,
            businessEmail: businessEmail,
          ),
        );
      } else {
        emit(BusinessError(errorMessage: 'No local business data found.'));
      }
    } catch (e) {}
  }

  Future<void> _onGetBusinessCategories(
    GetBusinessCategoriesEvent event,
    Emitter<BusinessState> emit,
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

  Future<void> _onGetBusinessProducts(
    GetBusinessProductsEvent event,
    Emitter<BusinessState> emit,
  ) async {
    emit(BusinessProductsLoading());
    try {
      final response = await _getBusinessProductsUseCase.call();
      emit(
        BusinessProductsLoaded(message: response.message, data: response.data),
      );
    } catch (e) {
      emit(BusinessProductsError(errorMessage: _getCleanErrorMessage(e)));
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
