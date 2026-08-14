import 'package:campus_cart/components/button.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/create_account',
                    (route) => false,
                  );
                },
                child: Text(
                  "Skip",
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
                        'assets/images/splash_image.jpg',
                        fit: BoxFit.cover,
                        height: 500,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Discover Campus Gems',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Find and support student owned businesses right here on your campus. From freshly baked goods to unique crafts, discover the best of what your campus has to offer.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  SizedBox(height: 20),
                  Button(
                    buttonText: "Continue",
                    isIconButton: false,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/onboarding_screen_two');
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
