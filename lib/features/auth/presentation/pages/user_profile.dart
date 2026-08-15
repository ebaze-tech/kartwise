import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_cart/components/error.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:campus_cart/components/profile.dart';
import 'package:campus_cart/components/snackbar.dart';
import 'package:campus_cart/components/animated_loader.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_event.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_state.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_bloc.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_event.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_state.dart';

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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/business_owner_dashboard');
          },
          icon: Icon(Icons.arrow_back),
        ),
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
                CustomSnackBar.show(
                  message: state.errorMessage,
                  context: context,
                  isError: true,
                );
              }
            },
          ),
          BlocListener<BusinessBloc, BusinessState>(
            listener: (context, state) {
              if (state is BusinessError) {
                CustomSnackBar.show(
                  message: state.errorMessage,
                  context: context,
                  isError: true,
                );
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
                  return const AnimatedLoadingPage(
                    message: 'Loading profile...',
                  );
                }

                if (authState is UserProfileError) {
                  return CustomError(
                    message: authState.errorMessage,
                    onRetry: () =>
                        context.read<AuthBloc>().add(UserProfileEvent()),
                  );
                }

                if (authState is UserProfileLoaded) {
                  if (businessState is BusinessError &&
                      !businessState.errorMessage.contains(
                        'No business data found',
                      )) {
                    return CustomError(
                      message: businessState.errorMessage,
                      onRetry: () =>
                          context.read<BusinessBloc>().add(GetBusinessEvent()),
                    );
                  }

                  return Center(
                    child: Profile(
                      userProfileEntity: authState.data,
                      businessEntity:
                          (businessState is BusinessLoaded &&
                              businessState.data.isNotEmpty)
                          ? businessState.data.first
                          : null,
                    ),
                  );
                }

                return const AnimatedLoadingPage(message: 'Loading profile...');
              },
            );
          },
        ),
      ),
    );
  }
}
