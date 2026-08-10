import 'package:campus_cart/components/profile.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_event.dart';
import 'package:campus_cart/components/spinner.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_state.dart';
import 'package:campus_cart/features/business/domain/entities/business_entity.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)?.settings.arguments;
    BusinessEntity? business;

    if (argument is BusinessEntity) {
      business = argument;
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: DefaultColors.background),
        backgroundColor: DefaultColors.primary,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'User Profile',
              style: TextStyle(
                color: DefaultColors.background,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings),
              color: DefaultColors.background,
              iconSize: 30,
            ),
          ],
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return Center(child: const GradientSpinner(size: 50));
          }
          if (state is UserProfileLoaded) {
            final userProfile = state.data;

            return Center(
              child: Profile(
                userProfileEntity: userProfile,
                businessEntity: business,
              ),
            );
          }
          if (state is UserProfileError) {
            return SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
              padding: EdgeInsets.zero,
              margin: const EdgeInsets.all(16),
              duration: const Duration(seconds: 4),
              content: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: DefaultColors.danger,
                  boxShadow: const [
                    BoxShadow(
                      color: DefaultColors.neutral,
                      blurRadius: 8.0,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: DefaultColors.neutral, width: 1),
                ),
                child: Text(
                  state.errorMessage,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: DefaultColors.whiteText,
                    backgroundColor: DefaultColors.danger,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
