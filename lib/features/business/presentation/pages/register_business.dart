import 'dart:io';

import 'package:campus_cart/components/animated_loader.dart';
import 'package:campus_cart/components/button.dart';
import 'package:campus_cart/components/dropdown.dart';
import 'package:campus_cart/components/form.dart';
import 'package:campus_cart/components/snackbar.dart';
import 'package:campus_cart/components/spinner.dart';
import 'package:campus_cart/components/toggle.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_event.dart';
import 'package:campus_cart/features/auth/presentation/bloc/auth_state.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_bloc.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_category_bloc.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_category_event.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_category_state.dart';
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

  void _onRegisterBusiness(final String categoryName) {
    if (_formKey.currentState!.validate()) {
      context.read<BusinessBloc>().add(
        CreateBusinessEvent(
          name: _businessNameController.text,
          description: _businessDescriptionController.text,
          emailAddress: _businessEmailController.text,
          phoneNumber: _businessPhoneController.text,
          businessCategoryName: categoryName,
          address: _businessAddressController.text,
          isActive: _isActiveController,
          bannerImage: _bannerImage,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    context.read<BusinessCategoryBloc>().add(GetBusinessCategoriesEvent());
    context.read<AuthBloc>().add(CheckAuthStatusEvent());
  }

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
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure && state.errorMessage.isNotEmpty) {
              CustomSnackBar.show(
                message: state.errorMessage,
                context: context,
                isError: true,
              );
              Navigator.pushReplacementNamed(context, '/signin_account');
            }
          },
          child: SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10),
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
                    BlocConsumer<BusinessCategoryBloc, BusinessCategoryState>(
                      listener: (context, state) {
                        if (state is BusinessCategoryError) {
                          CustomSnackBar.show(
                            message: state.errorMessage,
                            context: context,
                            isError: true,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is BusinessCategoryLoaded) {
                          return CustomDropdownField<String>(
                            labelText: 'Business Category',
                            icon: Icons.category,
                            value: _selectedCategory,
                            items: state.data!.map((category) {
                              return DropdownMenuItem<String>(
                                value: category.name,
                                child: Text(
                                  category.name,
                                  style: Theme.of(context).textTheme.bodyMedium,
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
                      keyboardType: TextInputType.phone,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GestureDetector(
                        onTap: _pickBannerImage,
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: DefaultColors.neutral.withValues(
                              alpha: 0.2,
                            ), // Adjust to your theme
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: DefaultColors.neutral,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                            // If an image is selected, display it
                            image: _bannerImage != null
                                ? DecorationImage(
                                    image: FileImage(_bannerImage!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _bannerImage == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_a_photo,
                                      size: 40,
                                      color: Theme.of(context).primaryColor,
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
                                        _bannerImage =
                                            null; // Allow user to remove the image
                                      });
                                    },
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 16.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Business Status",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(width: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CustomToggle(
                              isActive: _isActiveController,
                              onChanged: (value) {
                                setState(() {
                                  _isActiveController = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    BlocConsumer<BusinessBloc, BusinessState>(
                      builder: (context, state) {
                        if (state is BusinessLoading) {
                          return const AnimatedLoadingPage(
                            message: 'Loading...',
                          );
                          // return GradientSpinner(size: 50);
                        }
                        return Button(
                          buttonText: "Create Business",
                          isIconButton: false,
                          onPressed: () {
                            if (_selectedCategory != null) {
                              _onRegisterBusiness(_selectedCategory!);
                            } else {
                              CustomSnackBar.show(
                                message: 'Please select a business category.',
                                context: context,
                                isError: true,
                              );
                            }
                          },
                        );
                      },
                      listener: (context, state) {
                        if (state is BusinessLoaded) {
                          CustomSnackBar.show(
                            message: state.message,
                            context: context,
                            isError: false,
                          );
                          context.read<ActiveBusinessCubit>().setActiveBusiness(
                            state.data.id,
                          );
                          Navigator.pushReplacementNamed(
                            context,
                            '/business_created',
                            arguments: state.data,
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
