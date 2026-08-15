import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_cart/components/button.dart';
import 'package:campus_cart/components/spinner.dart';
import 'package:campus_cart/components/snackbar.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_event.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_state.dart';

class ConfirmEmailUpdate extends StatefulWidget {
  const ConfirmEmailUpdate({super.key});

  @override
  State<ConfirmEmailUpdate> createState() => _ConfirmEmailUpdateState();
}

class _ConfirmEmailUpdateState extends State<ConfirmEmailUpdate> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onVerifyEmail() {
    final pin = _otpController.text.trim();
    if (pin.isEmpty || pin.length != 6) {
      CustomSnackBar.show(
        message: 'Please enter the complete 6-digit code.',
        context: context,
        isError: true,
      );
    } else {
      // print('Entered OTP: $pin');
      BlocProvider.of<AuthBloc>(
        context,
      ).add(ConfirmEmailUpdateEvent(otp: _otpController.text.trim()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(8),
    );
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mark_email_read_rounded,
                size: 100,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 20),
              Text(
                'Check Your Email',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  'A verification code has been sent to your email. Check your inbox and enter the code below.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              SizedBox(height: 30),
              Pinput(
                length: 6,
                controller: _otpController,
                focusNode: _focusNode,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                onCompleted: (pin) {
                  _onVerifyEmail();
                },
              ),
              SizedBox(height: 20),
              BlocConsumer<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is ConfirmEmailUpdateLoading) {
                    return GradientSpinner(size: 50);
                  }
                  return Column(
                    children: [
                      Button(
                        buttonText: "Verify Email",
                        isIconButton: false,
                        onPressed: _onVerifyEmail,
                      ),
                    ],
                  );
                },
                listener: (context, state) {
                  if (state is ConfirmEmailUpdateSuccess) {
                    CustomSnackBar.show(
                      message: state.message,
                      context: context,
                      isError: false,
                    );
                    Navigator.of(context).pushNamed('/user_profile');
                  } else if (state is ConfirmEmailUpdateError) {
                    CustomSnackBar.show(
                      message: state.errorMessage,
                      context: context,
                      isError: true,
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
