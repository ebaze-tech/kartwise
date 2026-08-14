import 'package:campus_cart/features/business/domain/usecases/business_products_usecase.dart';
import 'package:campus_cart/features/business/domain/usecases/business_registration_usecase.dart';
import 'package:campus_cart/features/business/domain/usecases/business_update_usecase.dart';
import 'package:campus_cart/features/business/domain/usecases/business_usecase.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_event.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BusinessBloc extends Bloc<BusinessEvent, BusinessState> {
  final BusinessRegistrationUseCase _businessRegistrationUseCase;
  final BusinessUpdateUsecase _businessUpdateUseCase;
  final BusinessProductsUsecase _getBusinessProductsUseCase;
  final BusinessUseCase _getBusinessUseCase;
  final _storage = FlutterSecureStorage();

  BusinessBloc({
    required this._businessRegistrationUseCase,
    required this._businessUpdateUseCase,
    required this._getBusinessProductsUseCase,
    required this._getBusinessUseCase,
  }) : super(BusinessInitial()) {
    on<CreateBusinessEvent>(_onCreateBusiness);
    on<UpdateBusinessEvent>(_onUpdateBusiness);
    on<GetLocalBusinessEvent>(_onGetLocalBusiness);
    on<GetBusinessProductsEvent>(_onGetBusinessProducts);
    on<GetBusinessProductByIdEvent>(_onGetBusinessProductById);
    on<GetBusinessEvent>(_onGetBusiness);
    on<CreateProductEvent>(_onCreateProduct);
    on<GetBusinessCategoriesEvent>(_onGetBusinessCategories);
    on<GetBusinessProductCategoriesEvent>(_onGetBusinessProductCategories);
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
      await _storage.write(key: 'businessId', value: response.data.id);
      await _storage.write(key: 'businessName', value: response.data.name);
      await _storage.write(
        key: 'businessEmail',
        value: response.data.emailAddress,
      );
      await _storage.write(
        key: 'businessPhone',
        value: response.data.phoneNumber,
      );
      emit(BusinessLoaded(message: response.message, data: [response.data]));
    } catch (e) {
      emit(BusinessError(errorMessage: _getCleanErrorMessage(e)));
    }
  }

  Future<void> _onUpdateBusiness(
    UpdateBusinessEvent event,
    Emitter<BusinessState> emit,
  ) async {
    emit(BusinessUpdateLoading());
    try {
      final response = await _businessUpdateUseCase.call(
        event.id,
        event.name,
        event.description,
        event.emailAddress,
        event.phoneNumber,
        event.categoryName,
        event.address,
        event.isActive,
        event.bannerImage,
      );

      await _storage.write(key: 'businessId', value: response.data.id);
      await _storage.write(key: 'businessName', value: response.data.name);
      await _storage.write(
        key: 'businessEmail',
        value: response.data.emailAddress,
      );
      await _storage.write(
        key: 'businessPhone',
        value: response.data.phoneNumber,
      );
      emit(
        BusinessUpdateLoaded(message: response.message, data: [response.data]),
      );
    } catch (e) {
      emit(BusinessUpdateError(errorMessage: _getCleanErrorMessage(e)));
    }
  }

  Future<void> _onGetBusiness(
    GetBusinessEvent event,
    Emitter<BusinessState> emit,
  ) async {
    emit(BusinessLoading());
    try {
      final response = await _getBusinessUseCase.call();
      await _storage.write(key: 'businessId', value: response.data.id);
      await _storage.write(key: 'businessName', value: response.data.name);
      await _storage.write(
        key: 'businessEmail',
        value: response.data.emailAddress,
      );
      await _storage.write(
        key: 'businessPhone',
        value: response.data.phoneNumber,
      );
      emit(BusinessLoaded(message: response.message, data: [response.data]));
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
      final businessPhone = await _storage.read(key: 'businessPhone');

      print(
        'Local Business Data: ID=$businessId, Name=$businessName, Email=$businessEmail, Phone=$businessPhone',
      );

      if (businessId != null &&
          businessName != null &&
          businessEmail != null &&
          businessPhone != null) {
        emit(
          LocalBusinessLoaded(
            businessId: businessId,
            businessName: businessName,
            businessEmail: businessEmail,
            businessPhone: businessPhone,
          ),
        );
      } else {
        emit(BusinessError(errorMessage: 'No local business data found.'));
      }
    } catch (e) {}
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

  Future<void> _onGetBusinessProductById(
    GetBusinessProductByIdEvent event,
    Emitter<BusinessState> emit,
  ) async {
    emit(BusinessProductByIdLoading());
    try {
      final response = await _getBusinessProductsUseCase.getBusinessProductById(
        event.productId,
      );
      emit(
        BusinessProductByIdLoaded(message: response.message, data: response.data),
      );
    } catch (e) {
      emit(BusinessProductByIdError(errorMessage: _getCleanErrorMessage(e)));
    }
  }

  Future<void> _onCreateProduct(
    CreateProductEvent event,
    Emitter<BusinessState> emit,
  ) async {
    emit(CreateProductLoading());
    try {
      final businessName = await _storage.read(key: 'businessName');
      if (businessName == null) {
        emit(CreateProductError(errorMessage: 'Business name not found.'));
        return;
      }
      final response = await _getBusinessProductsUseCase.createProduct(
        name: event.name,
        description: event.description,
        price: event.price,
        stockCount: event.stockCount,
        businessName: businessName,
        productCategoryName: event.productCategoryName,
        isAvailable: event.isAvailable,
        images: event.images,
      );
      emit(CreateProductLoaded(message: response.message, data: response.data));
    } catch (e) {
      emit(CreateProductError(errorMessage: _getCleanErrorMessage(e)));
    }
  }

  Future<void> _onGetBusinessCategories(
    GetBusinessCategoriesEvent event,
    Emitter<BusinessState> emit,
  ) async {
    emit(BusinessCategoriesLoading());
    try {
      final response = await _getBusinessProductsUseCase
          .getBusinessCategories();
      emit(
        BusinessCategoriesLoaded(
          message: response.message,
          data: response.data,
        ),
      );
    } catch (e) {
      emit(BusinessCategoriesError(errorMessage: _getCleanErrorMessage(e)));
    }
  }

  Future<void> _onGetBusinessProductCategories(
    GetBusinessProductCategoriesEvent event,
    Emitter<BusinessState> emit,
  ) async {
    emit(BusinessCategoriesLoading());
    try {
      final response = await _getBusinessProductsUseCase
          .getBusinessProductCategories();
      emit(
        BusinessCategoriesLoaded(
          message: response.message,
          data: response.data,
        ),
      );
    } catch (e) {
      emit(BusinessCategoriesError(errorMessage: _getCleanErrorMessage(e)));
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
