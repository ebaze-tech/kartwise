import 'package:campus_cart/components/button.dart';
import 'package:campus_cart/components/snackbar.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_event.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';

class VerifyAccount extends StatefulWidget {
  const VerifyAccount({super.key});

  @override
  State<VerifyAccount> createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isVerifying = false;

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
      setState(() {
        _isVerifying = true;
      });

      BlocProvider.of<AuthBloc>(
        context,
      ).add(OtpEvent(otp: _otpController.text.trim()));
    }
  }

  void _onResendOtp() {
    _otpController.clear();
    _focusNode.requestFocus();

    setState(() {
      _isVerifying = false;
    });

    BlocProvider.of<AuthBloc>(context).add(ResendOtpEvent());
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
            const SizedBox(width: 5),
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
        child: Center(
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
                const SizedBox(height: 20),
                Text(
                  'Check Your Email',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'A verification code has been sent to your email. Check your inbox and enter the code below.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
                const SizedBox(height: 30),
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
                const SizedBox(height: 20),

                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      CustomSnackBar.show(
                        message: state.message,
                        context: context,
                        isError: false,
                      );

                      if (_isVerifying) {
                        Navigator.pushReplacementNamed(
                          context,
                          '/signin_account',
                        );
                      }
                    } else if (state is AuthFailure) {
                      CustomSnackBar.show(
                        message: state.errorMessage,
                        context: context,
                        isError: true,
                      );

                      setState(() {
                        _isVerifying = false;
                      });
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;

                    return Column(
                      children: [
                        Button(
                          buttonText: isLoading
                              ? (_isVerifying ? "Verifying..." : "Sending...")
                              : "Verify Email",
                          isIconButton: false,
                          onPressed: isLoading ? () {} : _onVerifyEmail,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't receive the code?",
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                            GestureDetector(
                              onTap: isLoading ? null : _onResendOtp,
                              child: Text(
                                " Resend Code",
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: isLoading
                                          ? Colors.grey
                                          : Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
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
