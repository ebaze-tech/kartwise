import 'package:campus_cart/components/button.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:flutter/material.dart';

class OnboardingThree extends StatelessWidget {
  const OnboardingThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Back",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: DefaultColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/images/splash_image_three.jpg',
                        fit: BoxFit.cover,
                        height: 500,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Shop. Sell. Support.',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Join hundreds of students already trading on Campus Cart. Discover unique items, support your peers, and make campus life easier.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  SizedBox(height: 20),
                  Button(
                    buttonText: "Setup Account",
                    isIconButton: false,
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/signup_account",
                        (route) => false,
                      );
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
