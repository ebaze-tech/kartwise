import 'package:campus_cart/components/button.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:flutter/material.dart';

class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({super.key});

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
                        'assets/images/splash_image_two.jpg',
                        fit: BoxFit.cover,
                        height: 500,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Launch Your Business',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Turn your passion into profit. Set up a professional digital storefront in minutes, manage orders effortlessly and start selling to your campus community today',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  SizedBox(height: 20),
                  Button(
                    buttonText: "Continue",
                    isIconButton: true,
                    onPressed: () {
                      Navigator.pushNamed(context, '/onboarding_screen_three');
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
