import 'package:campus_cart/features/auth/domain/usecases/confirm_email_update_usecase.dart';
import 'package:campus_cart/features/auth/domain/usecases/request_email_update_usecase.dart';
import 'package:campus_cart/features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:campus_cart/features/auth/domain/usecases/update_password_usecase.dart';
import 'package:campus_cart/features/auth/domain/usecases/user_profile_usecase.dart';
import 'package:campus_cart/features/auth/domain/usecases/verify_email_usecase.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_cart/features/auth/domain/usecases/login_usecase.dart';
import 'package:campus_cart/features/auth/domain/usecases/update_profile_usecase.dart';
import 'package:campus_cart/features/auth/domain/usecases/register_usecase.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_event.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUsecase registerUsecase;
  final LoginUsecase loginUsecase;
  final VerifyEmailUsecase verifyEmailUsecase;
  final ResendOtpUsecase resendOtpUsecase;
  final UserProfileUsecase userProfileUsecase;
  final RequestEmailUpdateUsecase requestEmailUpdateUsecase;
  final ConfirmEmailUpdateUsecase confirmEmailUpdateUsecase;
  final UpdateProfileUseCase updateProfileUsecase;
  final UpdatePasswordUsecase updatePasswordUsecase;
  final _storage = FlutterSecureStorage();

  AuthBloc({
    required this.registerUsecase,
    required this.loginUsecase,
    required this.verifyEmailUsecase,
    required this.resendOtpUsecase,
    required this.userProfileUsecase,
    required this.requestEmailUpdateUsecase,
    required this.confirmEmailUpdateUsecase,
    required this.updateProfileUsecase,
    required this.updatePasswordUsecase,
  }) : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
    on<OtpEvent>(_onVerifyEmail);
    on<ResendOtpEvent>(_onResendOtp);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<LogoutEvent>(_onLogout);
    on<UserProfileEvent>(_onGetUserProfile);
    on<UpdatePermanentAddressEvent>(_onUpdateUserProfile);
    on<RequestEmailUpdateEvent>(_onRequestEmailUpdate);
    on<ConfirmEmailUpdateEvent>(_onConfirmEmailUpdate);
    on<UpdatePasswordEvent>(_onUpdatePassword);
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await registerUsecase.call(
        event.email,
        event.password,
        event.firstName,
        event.lastName,
        event.role,
      );
      await _storage.write(key: 'userId', value: response.id);
      await _storage.write(key: 'email', value: response.email);
      await _storage.write(key: 'role', value: response.role);
      emit(AuthSuccess(message: response.message));
    } catch (e) {
      emit(AuthFailure(errorMessage: _getCleanErrorMessage(e)));
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUsecase.call(event.email, event.password);
      await _storage.write(key: 'accessToken', value: user.accessToken);
      await _storage.write(key: 'role', value: user.role);
      emit(AuthSuccess(message: user.message, role: user.role));
    } catch (e) {
      emit(AuthFailure(errorMessage: _getCleanErrorMessage(e)));
    }
  }

  Future<void> _onVerifyEmail(OtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final otp = await verifyEmailUsecase.call(event.otp);
      final role = await _storage.read(key: 'role');
      emit(AuthSuccess(message: otp.message, role: role));
    } catch (e) {
      emit(AuthFailure(errorMessage: _getCleanErrorMessage(e)));
    }
  }

  Future<void> _onResendOtp(
    ResendOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final role = await _storage.read(key: 'role');
    try {
      final otp = await resendOtpUsecase.call();
      emit(AuthSuccess(message: otp.message, role: role));
    } catch (e) {
      print(e.toString());
      emit(AuthFailure(errorMessage: _getCleanErrorMessage(e)));
    }
  }

  Future<void> _onRequestEmailUpdate(
    RequestEmailUpdateEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(RequestEmailUpdateLoading());
    try {
      final response = await requestEmailUpdateUsecase.call(
        event.currentEmail,
        event.newEmail,
      );
      emit(RequestEmailUpdateSuccess(message: response.message));
    } catch (e) {
      emit(RequestEmailUpdateError(errorMessage: _getCleanErrorMessage(e)));
    }
  }

  Future<void> _onConfirmEmailUpdate(
    ConfirmEmailUpdateEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(ConfirmEmailUpdateLoading());
    try {
      final response = await confirmEmailUpdateUsecase.call(event.otp);
      emit(ConfirmEmailUpdateSuccess(message: response.message));
    } catch (e) {
      emit(ConfirmEmailUpdateError(errorMessage: _getCleanErrorMessage(e)));
    }
  }

  Future<void> _onUpdatePassword(
    UpdatePasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(UpdateUserPasswordLoading());
    try {
      final response = await updatePasswordUsecase.call(
        event.currentPassword,
        event.newPassword,
      );
      emit(UpdateUserPasswordSuccess(message: response.message));
    } catch (e) {
      emit(UpdateUserPasswordError(errorMessage: _getCleanErrorMessage(e)));
    }
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final accessToken = await _storage.read(key: 'accessToken');
      final role = await _storage.read(key: 'role');

      if (accessToken != null && role != null) {
        emit(
          AuthSuccess(
            message: 'User is authenticated',
            role: role,
            accessToken: accessToken,
          ),
        );
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthFailure(errorMessage: _getCleanErrorMessage(e)));
    }
  }

  Future<void> _onGetUserProfile(
    UserProfileEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(UserProfileLoading());
    try {
      final response = await userProfileUsecase.call();
      print(response.data);
      emit(UserProfileLoaded(data: response.data, message: response.message));
    } catch (e) {
      emit(UserProfileError(errorMessage: _getCleanErrorMessage(e)));
    }
  }

  Future<void> _onUpdateUserProfile(
    UpdatePermanentAddressEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(UpdatePermanentAddressLoading());
    try {
      final response = await updateProfileUsecase.call(event.permanentAddress);
      print(response.data);
      emit(
        UpdatePermanentAddressSuccess(
          data: response.data,
          message: response.message,
        ),
      );
    } catch (e) {
      emit(UpdatePermanentAddressError(errorMessage: _getCleanErrorMessage(e)));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await _storage.deleteAll();
    emit(AuthInitial());
  }

  String _getCleanErrorMessage(Object e) {
    final errorStr = e.toString();
    if (errorStr.startsWith('Exception: ')) {
      return errorStr.replaceFirst('Exception: ', '');
    }
    return errorStr;
  }
}
