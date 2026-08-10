import 'package:campus_cart/components/button.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:campus_cart/features/business/domain/entities/business_entity.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final Map<String, dynamic> userProfileEntity;
  final BusinessEntity? businessEntity;

  const Profile({
    super.key,
    required this.userProfileEntity,
    this.businessEntity,
  });

  @override
  Widget build(BuildContext context) {
    final String firstName = userProfileEntity['firstName'] ?? 'N/A';
    final String lastName = userProfileEntity['lastName'] ?? 'N/A';
    final String fullName = '$firstName $lastName'.trim();
    final String email = userProfileEntity['email'] ?? 'N/A';
    final String emailVerified = userProfileEntity['emailVerified'] == true
        ? 'Verified'
        : 'Not Verified';

    final String role = userProfileEntity['role'] == 'BUSINESS_OWNER'
        ? 'Student Entrepreneur'
        : 'Student';

    final String university = userProfileEntity['university'] ?? 'N/A';

    final String storeName = businessEntity?.name.isNotEmpty == true
        ? businessEntity!.name
        : 'My Store';

    final String storeStatus = businessEntity?.isActive == true
        ? 'Active'
        : 'Inactive';

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildHeader(context, fullName, role),
          const SizedBox(height: 32),

          _buildSectionCard(
            context: context,
            title: 'PERSONAL INFORMATION',
            trailingHeader: _buildActiveBadge(status: emailVerified),
            items: [
              _buildListItem(
                context: context,
                icon: Icons.person_outline,
                label: 'Full Name',
                value: fullName,
                onTap: () {},
              ),
              const Divider(height: 1, indent: 56),
              _buildListItem(
                context: context,
                icon: Icons.mail_outline,
                label: 'Email Address',
                value: email,
                onTap: () {
                  // update email address action
                  Navigator.pushNamed(
                    context,
                    '/update_email',
                    arguments: email,
                  );
                },
                trailingIcon: Icons.chevron_right,
              ),
              const Divider(height: 1, indent: 56),
              _buildListItem(
                context: context,
                icon: Icons.school_outlined,
                label: 'University',
                value: university,
                onTap: () {
                  // update university action
                  Navigator.pushNamed(context, '/update_university');
                },
                trailingIcon: Icons.chevron_right,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 3. Business Profile Section
          _buildSectionCard(
            context: context,
            title: 'BUSINESS PROFILE',
            trailingHeader: _buildActiveBadge(status: storeStatus),
            items: [
              _buildListItem(
                context: context,
                icon: Icons.storefront_outlined,
                label: 'Store Name',
                value: storeName,
                onTap: () {
                  // update store name action
                  Navigator.pushNamed(context, '/update_business');
                },
                trailingIcon: Icons.chevron_right,
              ),
              const Divider(height: 1, indent: 56),
              _buildListItem(
                context: context,
                icon: Icons.payments_outlined,
                label: 'Payment Methods',
                value: 'Cash, Transfer, Card',
                onTap: () {
                  // update payment methods action
                  Navigator.pushNamed(context, '/update_payment_methods');
                },
                trailingIcon: Icons.chevron_right,
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildSectionCard(
            context: context,
            title: 'SECURITY & PREFERENCES',
            items: [
              _buildActionItem(
                context: context,
                icon: Icons.lock_outline,
                label: 'Change Password',
                onTap: () {
                  // update password action
                  Navigator.pushNamed(context, '/update_password');
                },
              ),
              const Divider(height: 1, indent: 56),
              _buildActionItem(
                context: context,
                icon: Icons.notifications_none_outlined,
                label: 'Notification Settings',
                onTap: () {
                  // update notification settings action
                  // Navigator.pushNamed(context, '/update_notification_settings');
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Button(
          //   buttonText: "Edit Profile",
          //   isIconButton: false,
          //   onPressed: () {
          //     // Handle edit profile action
          //   },
          //   buttonColor: DefaultColors.primary,
          // ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String name, String role) {
    return Column(
      children: [
        Stack(
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: DefaultColors.gray,
              backgroundImage: AssetImage('assets/images/person.png'),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: DefaultColors.primary, // The green edit badge color
                  shape: BoxShape.circle,
                  border: Border.all(color: DefaultColors.background, width: 2),
                ),
                child: const Icon(
                  Icons.edit,
                  size: 14,
                  color: DefaultColors.background,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            role,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required BuildContext context,
    required String title,
    required List<Widget> items,
    Widget? trailingHeader,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: DefaultColors.gray.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                ?trailingHeader,
              ],
            ),
          ),
          const Divider(height: 1),
          ...items,
        ],
      ),
    );
  }

  Widget _buildListItem({
    required BuildContext context,
    required IconData icon,
    IconData? trailingIcon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Icon(icon, color: DefaultColors.primary),
      title: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: DefaultColors.gray),
      ),
      trailing: trailingIcon != null
          ? Icon(trailingIcon, color: DefaultColors.gray)
          : null,
      subtitle: Text(
        value,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: DefaultColors.neutral,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildActionItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Icon(icon, color: DefaultColors.primary),
      title: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: DefaultColors.neutral,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: DefaultColors.gray),
    );
  }

  Widget _buildActiveBadge({required String status}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: status == 'Active' || status == 'Verified'
            ? DefaultColors.success
            : DefaultColors.warning,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
