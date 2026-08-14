import 'dart:io';
import 'package:campus_cart/components/button.dart';
import 'package:campus_cart/components/dropdown.dart';
import 'package:campus_cart/components/form.dart';
import 'package:campus_cart/components/snackbar.dart';
import 'package:campus_cart/components/toggle.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_state.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_bloc.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_event.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_state.dart';
import 'package:campus_cart/features/business/presentation/cubit/activate_business.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class RegisterBusiness extends StatefulWidget {
  const RegisterBusiness({super.key});

  @override
  State<RegisterBusiness> createState() => _RegisterBusinessState();
}

class _RegisterBusinessState extends State<RegisterBusiness> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _businessAddressController =
      TextEditingController();
  final TextEditingController _businessPhoneController =
      TextEditingController();
  final TextEditingController _businessEmailController =
      TextEditingController();
  final TextEditingController _businessDescriptionController =
      TextEditingController();
  final TextEditingController _businessCategoryController =
      TextEditingController();

  String? _selectedCategory;
  bool _isActiveController = true;
  File? _bannerImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _businessNameController.dispose();
    _businessAddressController.dispose();
    _businessPhoneController.dispose();
    _businessEmailController.dispose();
    _businessDescriptionController.dispose();
    _businessCategoryController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<BusinessBloc>().add(GetBusinessCategoriesEvent());
    // context.read<AuthBloc>().add(CheckAuthStatusEvent());
  }

  Future<void> _pickBannerImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _bannerImage = File(pickedFile.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _bannerImage?.delete();
    });
  }

  void _onRegisterBusiness() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCategory == null || _selectedCategory!.isEmpty) {
        CustomSnackBar.show(
          message: 'Please select a business category.',
          context: context,
          isError: true,
        );
        return;
      }

      if (_bannerImage == null) {
        CustomSnackBar.show(
          context: context,
          message: 'Plase add a banner image',
          isError: true,
        );
      }
      context.read<BusinessBloc>().add(
        CreateBusinessEvent(
          name: _businessNameController.text.trim(),
          description: _businessDescriptionController.text.trim(),
          emailAddress: _businessEmailController.text.trim(),
          phoneNumber: _businessPhoneController.text.trim(),
          businessCategoryName: _selectedCategory!,
          address: _businessAddressController.text.trim(),
          isActive: _isActiveController,
          bannerImage: _bannerImage,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColors.background,
      appBar: AppBar(
        backgroundColor: DefaultColors.primary,
        title: Text(
          'Create Your Business',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: DefaultColors.whiteText,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure && state.errorMessage.isNotEmpty) {
                  CustomSnackBar.show(
                    context: context,
                    message: state.errorMessage,
                    isError: true,
                  );
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/signin_account',
                    (route) => false,
                  );
                }
              },
            ),
            BlocListener<BusinessBloc, BusinessState>(
              listener: (context, state) {
                if (state is BusinessLoaded) {
                  CustomSnackBar.show(
                    message: state.message,
                    context: context,
                    isError: false,
                  );
                  context.read<ActiveBusinessCubit>().setActiveBusiness(
                    state.data.first.id,
                  );
                  Navigator.pushReplacementNamed(
                    context,
                    '/business_created',
                    arguments: state.data.first,
                  );
                } else if (state is BusinessError) {
                  CustomSnackBar.show(
                    message: state.errorMessage,
                    context: context,
                    isError: true,
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<BusinessBloc, BusinessState>(
            builder: (context, businessState) {
              final isLoading = businessState is BusinessLoading;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSectionCard(
                        context: context,
                        title: 'Business Details',
                        items: [
                          CustomFormField(
                            icon: Icons.business,
                            controller: _businessNameController,
                            labelText: "Business name",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Business name is required";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            readOnly: false,
                          ),
                          CustomFormField(
                            icon: Icons.description,
                            controller: _businessDescriptionController,
                            labelText: "Business description",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Business description is required";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            readOnly: false,
                          ),
                          BlocConsumer<BusinessBloc, BusinessState>(
                            listener: (context, state) {
                              if (state is BusinessCategoriesError) {
                                CustomSnackBar.show(
                                  message: state.errorMessage,
                                  context: context,
                                  isError: true,
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is BusinessCategoriesLoaded) {
                                print(state.data.toString());
                                return CustomDropdownField<String>(
                                  labelText: 'Business Category',
                                  icon: Icons.category,
                                  value: _selectedCategory,
                                  items: state.data!.map((category) {
                                    return DropdownMenuItem<String>(
                                      value: category.name,
                                      child: Text(
                                        category.name,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedCategory = value;
                                    });
                                  },
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      _buildSectionCard(
                        context: context,
                        title: 'Contact Information',
                        items: [
                          CustomFormField(
                            controller: _businessAddressController,
                            labelText: "Business address",
                            icon: Icons.location_on,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Business address is required";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.streetAddress,
                            obscureText: false,
                            readOnly: false,
                          ),
                          CustomFormField(
                            controller: _businessEmailController,
                            labelText: "Business email address",
                            icon: Icons.email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Business email address is required";
                              }
                              if (!value.contains("@")) {
                                return "Valid email address is required";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            readOnly: false,
                          ),
                          CustomFormField(
                            controller: _businessPhoneController,
                            labelText: "Business phone number",
                            icon: Icons.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Business phone number is required";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            obscureText: false,
                            readOnly: false,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      _buildSectionCard(
                        context: context,
                        title: 'Store Banner',
                        items: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: GestureDetector(
                              onTap: _pickBannerImage,
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: DefaultColors.neutral.withValues(
                                    alpha: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: DefaultColors.neutral,
                                    width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                  image: _bannerImage != null
                                      ? DecorationImage(
                                          image: FileImage(_bannerImage!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: _bannerImage == null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_a_photo,
                                            size: 40,
                                            color: Theme.of(
                                              context,
                                            ).primaryColor,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Tap to upload a banner image',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                          ),
                                        ],
                                      )
                                    : Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.cancel,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _bannerImage = null;
                                            });
                                          },
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      _buildSectionCard(
                        context: context,
                        title: 'Settings',
                        items: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Store Status",
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                CustomToggle(
                                  isActive: _isActiveController,
                                  onChanged: (value) {
                                    setState(() {
                                      _isActiveController = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      Button(
                        buttonText: isLoading
                            ? "Creating..."
                            : "Create Business",
                        isIconButton: false,
                        onPressed: isLoading ? () {} : _onRegisterBusiness,
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
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
              right: 8,
              top: 12,
              bottom: 12,
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
}
