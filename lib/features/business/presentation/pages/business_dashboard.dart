import 'package:campus_cart/components/drawer.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:flutter/material.dart';

class BusinessDashboard extends StatefulWidget {
  const BusinessDashboard({super.key});

  @override
  State<BusinessDashboard> createState() => _BusinessDashboardState();
}

class _BusinessDashboardState extends State<BusinessDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: DefaultColors.background),
        backgroundColor: DefaultColors.primary,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Business Dashboard',
              style: TextStyle(
                color: DefaultColors.background,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
              color: DefaultColors.background,
              iconSize: 30,
            ),
          ],
        ),
      ),drawer: CustomDrawer(),
    );
  }
}
