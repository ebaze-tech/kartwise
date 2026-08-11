import 'package:campus_cart/components/button.dart';
import 'package:campus_cart/components/form.dart';
import 'package:campus_cart/components/snackbar.dart';
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/user_profile');
          },
        ),
        iconTheme: const IconThemeData(color: DefaultColors.background),
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  icon: Icons.school,
                  readOnly: false,
                ),
                const SizedBox(height: 32),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is UpdateUniversitySuccess) {
                      CustomSnackBar.show(
                        message: state.message,
                        context: context,
                        isError: false,
                      );
                      Navigator.pushNamed(context, '/user_profile');
                    } else if (state is UpdateUniversityError) {
                      CustomSnackBar.show(
                        message: state.errorMessage,
                        context: context,
                        isError: true,
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is UpdateUniversityLoading;
                    return Button(
                      buttonText: isLoading ? "Updating..." : "Done",
                      isIconButton: false,
                      onPressed: isLoading ? () {} : _updateUniversity,
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
