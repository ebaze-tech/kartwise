import 'package:campus_cart/components/button.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_event.dart';
import 'package:campus_cart/features/business/domain/entities/business_entity.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)?.settings.arguments;

    String businessName = 'My';
    String businessOwner = 'Business Owner';
    if (argument is BusinessEntity) {
      businessName = argument.name;
      businessOwner = argument.emailAddress;
    } else if (argument is LocalBusinessLoaded) {
      businessName = argument.businessName;
      businessOwner = argument.businessEmail;
    }

    return Drawer(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: DefaultColors.primary),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: DefaultColors.background,
                    child: const Icon(
                      Icons.storefront,
                      size: 35,
                      color: DefaultColors.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    businessName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: DefaultColors.background,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    businessOwner,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: DefaultColors.background.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              children: [
                _buildDrawerItem(
                  context: context,
                  icon: Icons.dashboard_rounded,
                  title: 'Dashboard',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigator.pushReplacementNamed(context, '/business_dashboard');
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.inventory_2_outlined,
                  title: 'Products',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigator.pushNamed(context, '/my_products');
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.shopping_bag_outlined,
                  title: 'Orders',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigator.pushNamed(context, '/orders');
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.store_outlined,
                  title: 'Store Settings',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigator.pushNamed(context, '/store_settings');
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.person_outline_rounded,
                  title: 'Profile',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      '/user_profile',
                      arguments: argument,
                    );
                  },
                ),
                const Divider(height: 30, thickness: 1),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),

          Button(
            buttonText: "Log Out",
            isIconButton: false,
            onPressed: () {
              context.read<AuthBloc>().add(LogoutEvent());
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/signin_account');
            },
            buttonColor: DefaultColors.danger,
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: DefaultColors.primary),
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
      hoverColor: DefaultColors.primary.withValues(alpha: 0.05),
    );
  }
}
