import 'package:campus_cart/components/animated_loader.dart';
import 'package:campus_cart/components/error.dart';
import 'package:campus_cart/components/snackbar.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_bloc.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_event.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_state.dart';
import 'package:campus_cart/features/business/presentation/cubit/activate_business.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessWrapper extends StatefulWidget {
  const BusinessWrapper({super.key});

  @override
  State<BusinessWrapper> createState() => _BusinessWrapperState();
}

class _BusinessWrapperState extends State<BusinessWrapper> {
  @override
  void initState() {
    super.initState();

    context.read<BusinessBloc>().add(GetBusinessEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BusinessBloc, BusinessState>(
        listener: (context, state) {
          if (state is BusinessLoaded) {
            print('Business Loaded: ${state.data}');
            if (state.data.isEmpty) {
              Navigator.of(context).pushReplacementNamed('/register_business');
              return;
            }

            final business = state.data.first;

            context.read<ActiveBusinessCubit>().setActiveBusiness(business.id);

            Navigator.of(
              context,
            ).pushReplacementNamed('/business_dashboard', arguments: business);
          }

          if (state is BusinessError) {
            CustomSnackBar.show(
              context: context,
              message: state.errorMessage,
              isError: true,
            );
          }
        },

        builder: (context, state) {
          if (state is BusinessLoading) {
            return const Center(
              child: AnimatedLoadingPage(message: 'Loading business...'),
            );
          }

          if (state is BusinessError) {
            print('Business Error: ${state.errorMessage}');
            Navigator.of(context).pushReplacementNamed('/register_business');
          }
          //   return Center(
          //     child: CustomError(
          //       message: 'An error occurred. Try again.',
          //       onRetry: () {
          //         context.read<BusinessBloc>().add(GetBusinessEvent());
          //       },
          //     ),
          //   );
          // }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
