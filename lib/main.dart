import 'package:campus_cart/components/spinner.dart';
import 'package:campus_cart/core/network/dio.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:campus_cart/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:campus_cart/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:campus_cart/features/auth/domain/usecases/login_usecase.dart';
import 'package:campus_cart/features/auth/domain/usecases/register_usecase.dart';
import 'package:campus_cart/features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:campus_cart/features/auth/domain/usecases/verify_email_usecase.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_event.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_state.dart';
import 'package:campus_cart/features/auth/presentation/pages/create_account.dart';
import 'package:campus_cart/features/business/presentation/pages/business_dashboard.dart';
import 'package:campus_cart/features/auth/presentation/pages/dashboard/buyer.dart';
import 'package:campus_cart/features/auth/presentation/pages/login_account.dart';
import 'package:campus_cart/features/auth/presentation/pages/verify_account.dart';
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

  final apiClient = ApiClient(
    onUnauthenticated: () {
      authBloc.add(LogoutEvent());
    },
  );

  final authRemoteDataSource = AuthRemoteDataSource(apiClient: apiClient);
  final authRepository = AuthRepositoryImpl(
    authRemoteDataSource: authRemoteDataSource,
  );

  authBloc = AuthBloc(
    registerUsecase: RegisterUsecase(authRepository: authRepository),
    loginUsecase: LoginUsecase(authRepository: authRepository),
    verifyEmailUsecase: VerifyEmailUsecase(authRepository: authRepository),
    resendOtpUsecase: ResendOtpUsecase(authRepository: authRepository),
  );

  runApp(MyApp(authBloc: authBloc));
}

class MyApp extends StatelessWidget {
  final AuthBloc authBloc;

  const MyApp({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: authBloc..add(CheckAuthStatusEvent()), // Fire startup check
        ),
      ],
      child: MaterialApp(
        title: 'KartWise',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: ((context, state) {
            if (state is AuthLoading) {
              return const Scaffold(
                body: Center(child: GradientSpinner(size: 50)),
              );
            }

            if (state is AuthSuccess) {
              if (state.role == 'BUSINESS_OWNER') {
                return const BusinessOwner();
              } else if (state.role == 'BUYER') {
                return const Buyer();
              }
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
          '/business_owner_dashboard': (context) => const BusinessOwner(),
          '/buyer_dashboard': (context) => const Buyer(),
        },
      ),
    );
  }
}
