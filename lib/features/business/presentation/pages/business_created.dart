import 'package:campus_cart/components/button.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:campus_cart/features/business/domain/entities/business_entity.dart';
import 'package:flutter/material.dart';

class BusinessCreated extends StatefulWidget {
  const BusinessCreated({super.key});

  @override
  State<BusinessCreated> createState() => _BusinessCreatedState();
}

class _BusinessCreatedState extends State<BusinessCreated> {
  @override
  Widget build(BuildContext context) {
    final businessData =
        ModalRoute.of(context)!.settings.arguments as BusinessEntity;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: DefaultColors.primary,
                size: 80,
              ),
              const SizedBox(height: 20),
              Text(
                'Congratulations!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  Text(
                    "${businessData.name} Store",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 5),
                  Text(' has been successfully created.'),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'A confirmation has been sent to ${businessData.emailAddress}.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 40),
              Button(
                buttonText: "Proceed to Dashboard",
                isIconButton: false,
                onPressed: () {
                  Navigator.of(context).pushNamed('/business_dashboard');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
