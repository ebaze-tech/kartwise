import 'dart:io';

import 'package:campus_cart/components/snackbar.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_event.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_state.dart';
import 'package:campus_cart/features/business/domain/entities/business_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  final Map<String, dynamic> userProfileEntity;
  final BusinessEntity? businessEntity;

  const Profile({
    super.key,
    required this.userProfileEntity,
    this.businessEntity,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _profilePicture;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickAndUpdateProfilePicture() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );

    if (pickedFile != null) {
      setState(() {
        _profilePicture = File(pickedFile.path);
      });

      if (mounted) {
        final permanentAddress =
            widget.userProfileEntity['permanentAddress'] as String?;

        if (permanentAddress != null) {
          context.read<AuthBloc>().add(
            UpdateUserAvatarEvent(profilePicture: _profilePicture!),
          );
        } else {
          if (mounted) {
            CustomSnackBar.show(
              context: context,
              message: 'No profile picture selected',
              isError: true,
            );
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final String firstName = widget.userProfileEntity['firstName'] ?? 'N/A';
    final String lastName = widget.userProfileEntity['lastName'] ?? 'N/A';
    final String fullName = '$firstName $lastName'.trim();
    final String email = widget.userProfileEntity['email'] ?? 'N/A';
    final String avatar = widget.userProfileEntity['profilePictureUrl'];
    final String emailVerified =
        widget.userProfileEntity['emailVerified'] == true
        ? 'Verified'
        : 'Not Verified';

    final String role = widget.userProfileEntity['role'] == 'BUSINESS_OWNER'
        ? 'Student Entrepreneur'
        : 'Student';

    final String permanentAddress = widget.userProfileEntity['permanentAddress'] ?? 'N/A';

    final String storeName = widget.businessEntity?.name.isNotEmpty == true
        ? widget.businessEntity!.name
        : 'My Store';

    final String storeStatus = widget.businessEntity?.isActive == true
        ? 'Active'
        : 'Inactive';

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildHeader(context, fullName, role, avatar),
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
              _buildListItem(
                context: context,
                icon: Icons.mail_outline,
                label: 'Email Address',
                value: email,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/update_email',
                    arguments: email,
                  );
                },
                trailingIcon: Icons.chevron_right,
              ),
              _buildListItem(
                context: context,
                icon: Icons.school_outlined,
                label: 'Permanent Address',
                value: permanentAddress,
                onTap: () {
                  Navigator.pushNamed(context, '/update_profile');
                },
                trailingIcon: Icons.chevron_right,
              ),
            ],
          ),
          const SizedBox(height: 16),

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
                  Navigator.pushNamed(context, '/update_business');
                },
                trailingIcon: Icons.chevron_right,
              ),
              _buildListItem(
                context: context,
                icon: Icons.payments_outlined,
                label: 'Payment Methods',
                value: 'Cash, Transfer, Card',
                onTap: () {
                  Navigator.pushNamed(context, '/update_payment_methods');
                },
                trailingIcon: Icons.chevron_right,
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildSectionCard(
            context: context,
            title: 'SECURITY',
            items: [
              _buildActionItem(
                context: context,
                icon: Icons.lock_outline,
                label: 'Change Password',
                onTap: () {
                  Navigator.pushNamed(context, '/update_password');
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    String name,
    String role,
    String avatar,
  ) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: DefaultColors.gray,
              backgroundImage: _profilePicture != null
                  ? FileImage(_profilePicture!) as ImageProvider
                  : NetworkImage(avatar),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: DefaultColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: DefaultColors.background, width: 2),
                ),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is UpdateUserAvatarSuccess) {
                      print("profile picture updated: ${state.message}");
                      CustomSnackBar.show(
                        context: context,
                        message: state.message,
                        isError: false,
                      );

                      context.read<AuthBloc>().add(UserProfileEvent());
                    }

                    if (state is UpdateUserAvatarError) {
                      CustomSnackBar.show(
                        context: context,
                        message: state.errorMessage,
                        isError: true,
                      );
                    }
                  },
                  builder: (context, state) {
                    return IconButton(
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                        color: DefaultColors.background,
                      ),
                      onPressed: _pickAndUpdateProfilePicture,
                    );
                  },
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
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
