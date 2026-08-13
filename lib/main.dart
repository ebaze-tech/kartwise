import 'package:campus_cart/components/animated_loader.dart';
import 'package:campus_cart/core/network/dio.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:campus_cart/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:campus_cart/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:campus_cart/features/auth/domain/usecases/confirm_email_update_usecase.dart';
import 'package:campus_cart/features/auth/domain/usecases/login_usecase.dart';
import 'package:campus_cart/features/auth/domain/usecases/register_usecase.dart';
import 'package:campus_cart/features/auth/domain/usecases/request_email_update_usecase.dart';
import 'package:campus_cart/features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:campus_cart/features/auth/domain/usecases/update_password_usecase.dart';
import 'package:campus_cart/features/auth/domain/usecases/update_profile_usecase.dart';
import 'package:campus_cart/features/auth/domain/usecases/user_profile_usecase.dart';
import 'package:campus_cart/features/auth/domain/usecases/verify_email_usecase.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_event.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_state.dart';
import 'package:campus_cart/features/auth/presentation/pages/confirm_email_update.dart';
import 'package:campus_cart/features/auth/presentation/pages/create_account.dart';
import 'package:campus_cart/features/auth/presentation/pages/update_email.dart';
import 'package:campus_cart/features/auth/presentation/pages/update_password.dart';
import 'package:campus_cart/features/auth/presentation/pages/update_profile.dart';
import 'package:campus_cart/features/auth/presentation/pages/user_profile.dart';
import 'package:campus_cart/features/business/data/datasource/business_remote_data_source.dart';
import 'package:campus_cart/features/business/domain/repositories/business_repository_impl.dart';
import 'package:campus_cart/features/business/domain/usecases/business_products_usecase.dart';
import 'package:campus_cart/features/business/domain/usecases/business_registration_usecase.dart';
import 'package:campus_cart/features/business/domain/usecases/business_update_usecase.dart';
import 'package:campus_cart/features/business/domain/usecases/business_usecase.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_bloc.dart';
import 'package:campus_cart/features/business/presentation/cubit/activate_business.dart';
import 'package:campus_cart/features/business/presentation/pages/add_product.dart';
import 'package:campus_cart/features/business/presentation/pages/business_created.dart';
import 'package:campus_cart/features/business/presentation/pages/business_dashboard.dart';
import 'package:campus_cart/features/business/presentation/pages/product_details.dart';
import 'package:campus_cart/features/business/presentation/pages/products_screen.dart';
import 'package:campus_cart/features/business/presentation/pages/register_business.dart';
import 'package:campus_cart/features/auth/presentation/pages/dashboard/buyer.dart';
import 'package:campus_cart/features/auth/presentation/pages/login_account.dart';
import 'package:campus_cart/features/auth/presentation/pages/verify_account.dart';
import 'package:campus_cart/features/business/presentation/pages/update_business.dart';
import 'package:campus_cart/features/business/presentation/pages/wrapper_screen.dart';
import 'package:campus_cart/features/onboarding/presentation/onboarding_three.dart';
import 'package:campus_cart/features/onboarding/presentation/onboarding_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'features/onboarding/presentation/onboarding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  late AuthBloc authBloc;
  late BusinessBloc businessBloc;

  final apiClient = ApiClient(
    onUnauthenticated: () {
      authBloc.add(LogoutEvent());
    },
  );

  final authRemoteDataSource = AuthRemoteDataSource(apiClient: apiClient);
  final authRepository = AuthRepositoryImpl(
    authRemoteDataSource: authRemoteDataSource,
  );
  final businessRemoteDataSource = BusinessRemoteDataSource(
    apiClient: apiClient,
  );
  final businessRepository = BusinessRepositoryImpl(
    businessRemoteDataSource: businessRemoteDataSource,
  );

  authBloc = AuthBloc(
    registerUsecase: RegisterUsecase(authRepository: authRepository),
    loginUsecase: LoginUsecase(authRepository: authRepository),
    verifyEmailUsecase: VerifyEmailUsecase(authRepository: authRepository),
    resendOtpUsecase: ResendOtpUsecase(authRepository: authRepository),
    userProfileUsecase: UserProfileUsecase(authRepository: authRepository),
    requestEmailUpdateUsecase: RequestEmailUpdateUsecase(
      authRepository: authRepository,
    ),
    confirmEmailUpdateUsecase: ConfirmEmailUpdateUsecase(
      authRepository: authRepository,
    ),
    updateProfileUsecase: UpdateProfileUseCase(authRepository: authRepository),
    updatePasswordUsecase: UpdatePasswordUsecase(
      authRemoteDataSource: authRemoteDataSource,
    ),
  );

  businessBloc = BusinessBloc(
    businessRegistrationUseCase: BusinessRegistrationUseCase(
      repository: businessRepository,
    ),
    businessUpdateUseCase: BusinessUpdateUsecase(
      businessRepository: businessRepository,
    ),

    getBusinessProductsUseCase: BusinessProductsUsecase(
      repository: businessRepository,
    ),
    getBusinessUseCase: BusinessUseCase(repository: businessRepository),
  );

  runApp(MyApp(authBloc: authBloc, businessBloc: businessBloc));
}

class MyApp extends StatelessWidget {
  final AuthBloc authBloc;
  final BusinessBloc businessBloc;

  const MyApp({super.key, required this.authBloc, required this.businessBloc});

  @override
  Widget build(BuildContext context) {
    authBloc.add(CheckAuthStatusEvent());
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authBloc),
        BlocProvider.value(value: businessBloc),
        BlocProvider<ActiveBusinessCubit>(
          create: (context) => ActiveBusinessCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'PeerPlaza',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: ((context, state) {
            if (state is AuthLoading) {
              return AnimatedLoadingPage();
            }

            if (state is AuthSuccess) {
              if (state.role == 'BUSINESS_OWNER') {
                return const BusinessWrapper();
              } else if (state.role == 'BUYER') {
                return const Buyer();
              }
            }

            if (state is AuthFailure) {
              return LoginAccount();
            }
            return const Onboarding();
          }),
        ),
        routes: {
          'onboarding_screen': (context) => const Onboarding(),
          '/onboarding_screen_two': (context) => const OnboardingTwo(),
          '/onboarding_screen_three': (context) => const OnboardingThree(),
          '/signup_account': (context) => const CreateAccount(),
          '/signin_account': (context) => const LoginAccount(),
          '/verify_account': (context) => const VerifyAccount(),
          '/business_owner_dashboard': (context) => const BusinessWrapper(),
          '/buyer_dashboard': (context) => const Buyer(),
          '/business_created': (context) => const BusinessCreated(),
          '/business_dashboard': (context) => const BusinessDashboard(),
          '/business_wrapper': (context) => const BusinessWrapper(),
          '/register_business': (context) => const RegisterBusiness(),
          '/user_profile': (context) => const UserProfile(),
          '/update_email': (context) => const UpdateEmail(),
          '/update_password': (context) => const UpdatePassword(),
          '/update_profile': (context) => const UpdateProfile(),
          '/update_business': (context) => const UpdateBusiness(),
          '/confirm_email_update': (context) => const ConfirmEmailUpdate(),
          '/business_products': (context) => ProductsScreen(),
          '/add_product': (context) => const AddProduct(),
          '/product_details': (context) => const ProductDetails(),
        },
      ),
    );
  }
}
