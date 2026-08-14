import 'package:campus_cart/components/button.dart';
import 'package:campus_cart/components/form.dart';
import 'package:campus_cart/components/snackbar.dart';
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('/user_profile');
          },
        ),
        iconTheme: const IconThemeData(color: DefaultColors.background),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                CustomFormField(
                  controller: _currentEmailController,
                  labelText: "Current Email",
                  validator: null,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
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
                  icon: Icons.email_rounded,
                  readOnly: false,
                ),
                const SizedBox(height: 10),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is RequestEmailUpdateSuccess) {
                      CustomSnackBar.show(
                        message: state.message,
                        context: context,
                        isError: false,
                      );
                      Navigator.of(
                        context,
                      ).pushNamed('/confirm_email_update');
                    } else if (state is RequestEmailUpdateError) {
                      CustomSnackBar.show(
                        message: state.errorMessage,
                        context: context,
                        isError: true,
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is RequestEmailUpdateLoading;
                    return Button(
                      buttonText: isLoading
                          ? "Requesting..."
                          : "Request Email Update",
                      isIconButton: false,
                      onPressed: isLoading ? () {} : _updateEmail,
                      buttonColor: DefaultColors.primary,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
