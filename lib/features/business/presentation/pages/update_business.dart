import 'package:campus_cart/core/theme/theme.dart';
import 'package:flutter/material.dart';

class UpdateBusiness extends StatefulWidget {
  const UpdateBusiness({super.key});

  @override
  State<UpdateBusiness> createState() => _UpdateBusinessState();
}

class _UpdateBusinessState extends State<UpdateBusiness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DefaultColors.primary,
        title: Text(
          'Create Your Business',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: DefaultColors.whiteText,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        centerTitle: true,
      ),
      body: Center(child: Text('Update your business information here!')),
    );
  }
}
