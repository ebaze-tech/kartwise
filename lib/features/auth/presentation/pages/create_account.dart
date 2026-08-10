import 'package:campus_cart/components/button.dart';
import 'package:campus_cart/components/dropdown.dart';
import 'package:campus_cart/components/form.dart';
import 'package:campus_cart/components/spinner.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_event.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? _selectedRole;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        RegisterEvent(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          role: _roleController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    RegExp passwordRegex = RegExp(pattern);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
              height: 30,
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 5),
            Text(
              'PeerPlaza',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  'Create Your Account',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Join hundreds of students already trading on PeerPlaza. Discover unique items, support your peers, and make campus life easier.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                    textDirection: TextDirection.ltr,
                  ),
                ),
                SizedBox(height: 20),
                CustomFormField(
                  icon: Icons.email,
                  controller: _emailController,
                  labelText: "Email Address",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  labelTextStyle: Theme.of(context).textTheme.bodySmall,
                ),
                CustomFormField(
                  icon: Icons.person,
                  controller: _firstNameController,
                  labelText: "First Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  labelTextStyle: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(width: 10),
                CustomFormField(
                  icon: Icons.person,
                  controller: _lastNameController,
                  labelText: "Last Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  labelTextStyle: Theme.of(context).textTheme.bodySmall,
                ),
                CustomDropdownField<String>(
                  labelText: "Role",
                  value: _selectedRole,
                  icon: Icons.work,
                  items: const [
                    DropdownMenuItem(value: 'BUYER', child: Text('Buyer')),
                    DropdownMenuItem(
                      value: 'BUSINESS_OWNER',
                      child: Text('Business Owner'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedRole = value;
                      if (value != null) {
                        _roleController.text = value;
                      }
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a role';
                    }
                    return null;
                  },
                ),
                CustomFormField(
                  icon: Icons.lock,
                  controller: _passwordController,
                  labelText: "Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    if (!passwordRegex.hasMatch(value)) {
                      return 'Password must contain at least:\n- eight characters \n- one letter\n- one digit\n- one special character';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  labelTextStyle: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 5),
                BlocConsumer<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return GradientSpinner(size: 50.0);
                    }
                    return Column(
                      children: [
                        Button(
                          buttonText: "Create Account",
                          isIconButton: false,
                          onPressed: _onRegister,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/signin_account',
                                );
                              },
                              child: Text(
                                'Log In',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: DefaultColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: DefaultColors.whiteText,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: DefaultColors.success,
                        ),
                      );
                      Navigator.pushReplacementNamed(
                        context,
                        '/verify_account',
                      );
                    } else if (state is AuthFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
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
                              border: Border.all(
                                color: DefaultColors.neutral,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              state.errorMessage,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: DefaultColors.whiteText,
                                    backgroundColor: DefaultColors.danger,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }
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
