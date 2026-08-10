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

class UpdateEmail extends StatefulWidget {
  const UpdateEmail({super.key});

  @override
  State<UpdateEmail> createState() => _UpdateEmailState();
}

class _UpdateEmailState extends State<UpdateEmail> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentEmailController = TextEditingController();
  final TextEditingController _newEmailController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final argument = ModalRoute.of(context)?.settings.arguments;

    if (argument is String) {
      _currentEmailController.text = argument;
    }
  }

  @override
  void dispose() {
    _currentEmailController.dispose();
    _newEmailController.dispose();
    super.dispose();
  }

  void _updateEmail() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        RequestEmailUpdateEvent(
          currentEmail: _currentEmailController.text.trim(),
          newEmail: _newEmailController.text.trim(),
        ),
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
          'Update Email Address',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: DefaultColors.whiteText,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          textAlign: TextAlign.start,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              CustomFormField(
                controller: _currentEmailController,
                labelText: "Current Email",
                validator: null,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                labelTextStyle: Theme.of(context).textTheme.bodySmall,
                icon: Icons.email_rounded,
                readOnly: true,
              ),
              CustomFormField(
                controller: _newEmailController,
                labelText: "New Email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your preferred email address';
                  }
                  if (!value.contains("@")) {
                    return "Please input a valid email";
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                labelTextStyle: Theme.of(context).textTheme.bodySmall,
                icon: Icons.email_rounded,
                readOnly: false,
              ),
              SizedBox(height: 10),
              BlocConsumer<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is RequestEmailUpdateLoading) {
                    return GradientSpinner(size: 50);
                  }

                  return Button(
                    buttonText: "Request Email Update",
                    isIconButton: false,
                    onPressed: _updateEmail,
                  );
                },
                listener: (context, state) {
                  if (state is RequestEmailUpdateSuccess) {
                    CustomSnackBar(message: state.message, context: context);
                    Navigator.pushNamed(
                      context,
                      '/confirm_email_update',
                    );
                  } else if (state is RequestEmailUpdateError) {
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
      ),
    );
  }
}
