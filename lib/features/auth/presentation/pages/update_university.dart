import 'package:campus_cart/components/button.dart';
import 'package:campus_cart/components/form.dart';
import 'package:campus_cart/components/snackbar.dart';
import 'package:campus_cart/components/spinner.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_event.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUniversity extends StatefulWidget {
  const UpdateUniversity({super.key});

  @override
  State<UpdateUniversity> createState() => _UpdateUniversityState();
}

class _UpdateUniversityState extends State<UpdateUniversity> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _universityController = TextEditingController();

  @override
  void dispose() {
    _universityController.dispose();
    super.dispose();
  }

  void _updateUniversity() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        UpdateUniversityEvent(university: _universityController.text.trim()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: DefaultColors.background),
        backgroundColor: DefaultColors.primary,
        title: Text(
          'Update Details',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: DefaultColors.whiteText,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          textAlign: TextAlign.start,
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomFormField(
                    controller: _universityController,
                    labelText: "Enter University Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your university's name";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    labelTextStyle: Theme.of(context).textTheme.bodySmall,
                    icon: Icons.school,
                    readOnly: false,
                  ),
                  SizedBox(height: 10),
                  BlocConsumer<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is UpdateUniversityLoading) {
                        return GradientSpinner(size: 50);
                      }

                      return Button(
                        buttonText: "Done",
                        isIconButton: false,
                        onPressed: _updateUniversity,
                      );
                    },
                    listener: (context, state) {
                      if (state is UpdateUniversitySuccess) {
                        CustomSnackBar(
                          message: state.message,
                          context: context,
                        );
                        Navigator.pushNamed(context, '/user_profile');
                      } else if (state is UpdateUniversityError) {
                        CustomSnackBar(
                          message: state.errorMessage,
                          context: context,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
