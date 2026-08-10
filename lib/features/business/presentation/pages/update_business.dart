import 'package:campus_cart/components/snackbar.dart';
import 'package:campus_cart/components/spinner.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_bloc.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_event.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateBusiness extends StatefulWidget {
  const UpdateBusiness({super.key});

  @override
  State<UpdateBusiness> createState() => _UpdateBusinessState();
}

class _UpdateBusinessState extends State<UpdateBusiness> {
  @override
  void initState() {
    super.initState();

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
          'Update Business',
          style: TextStyle(
            color: DefaultColors.background,
            fontSize: FontSize.headingMedium,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            BlocConsumer<BusinessBloc, BusinessState>(
              builder: (context, state) {
                if (state is BusinessLoading) {
                  return GradientSpinner(size: 50);
                }
                return const SizedBox.shrink();
              },
              listener: (context, state) {
                if (state is BusinessLoaded) {
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: state.data.name,
                          decoration: const InputDecoration(
                            labelText: 'Business Name',
                          ),
                        ),
                        TextFormField(
                          initialValue: state.data.description,
                          decoration: const InputDecoration(
                            labelText: 'Business Description',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle form submission
                          },
                          child: const Text('Update Business'),
                        ),
                      ],
                    ),
                  );
                } else if (state is BusinessError) {
                  CustomSnackBar(message: state.errorMessage, context: context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
