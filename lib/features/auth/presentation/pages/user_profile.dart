import 'package:campus_cart/components/error.dart';
import 'package:campus_cart/components/profile.dart';
import 'package:campus_cart/components/snackbar.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_event.dart';
import 'package:campus_cart/components/spinner.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_state.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_bloc.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_event.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(UserProfileEvent());
    context.read<BusinessBloc>().add(GetBusinessEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: DefaultColors.background),
        backgroundColor: DefaultColors.primary,
        centerTitle: true,
        title: const Text(
          'User Profile',
          style: TextStyle(
            color: DefaultColors.background,
            fontSize: FontSize.headingMedium,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is UserProfileError) {
                CustomSnackBar(message: state.errorMessage, context: context);
              }
            },
          ),
          BlocListener<BusinessBloc, BusinessState>(
            listener: (context, state) {
              if (state is BusinessError) {
                CustomSnackBar(message: state.errorMessage, context: context);
              }
            },
          ),
        ],
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            return BlocBuilder<BusinessBloc, BusinessState>(
              builder: (context, businessState) {
                if (authState is UserProfileLoading ||
                    businessState is BusinessLoading) {
                  return const Center(child: GradientSpinner(size: 50));
                }

                if (authState is UserProfileLoaded &&
                    businessState is BusinessLoaded) {
                  return Center(
                    child: Profile(
                      userProfileEntity: authState.data,
                      businessEntity: businessState.data,
                    ),
                  );
                }

                if (authState is UserProfileError) {
                  return CustomError(
                    message: 'Failed to load user profile.',
                    onRetry: () =>
                        context.read<AuthBloc>().add(UserProfileEvent()),
                  );
                }

                if (businessState is BusinessError) {
                  return CustomError(
                    message: 'Failed to load business profile.',
                    onRetry: () =>
                        context.read<BusinessBloc>().add(GetBusinessEvent()),
                  );
                }

                return const SizedBox.shrink();
              },
            );
          },
        ),
      ),
    );
  }
}
