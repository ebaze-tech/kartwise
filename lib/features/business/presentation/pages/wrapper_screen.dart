import 'package:campus_cart/components/spinner.dart';
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
      body: BlocListener<BusinessBloc, BusinessState>(
        listener: (context, state) {
          if (state is BusinessLoaded) {
            context.read<ActiveBusinessCubit>().setActiveBusiness(
              state.data.id,
            );

            Navigator.pushReplacementNamed(
              context,
              '/business_dashboard',
              arguments: state.data,
            );
          } else if (state is BusinessError) {
            Navigator.pushReplacementNamed(context, '/register_business');
          }
        },
        child: const Center(child: GradientSpinner(size: 50)),
      ),
    );
  }
}
