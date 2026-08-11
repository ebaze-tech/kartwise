import 'dart:io';

import 'package:campus_cart/components/animated_loader.dart';
import 'package:campus_cart/components/button.dart';
import 'package:campus_cart/components/dropdown.dart';
import 'package:campus_cart/components/form.dart';
import 'package:campus_cart/components/snackbar.dart';
import 'package:campus_cart/components/spinner.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_bloc.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_category_bloc.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_category_event.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_category_state.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_event.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateBusiness extends StatefulWidget {
  const UpdateBusiness({super.key});

  @override
  State<UpdateBusiness> createState() => _UpdateBusinessState();
}

class _UpdateBusinessState extends State<UpdateBusiness> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _businessDescriptionController =
      TextEditingController();
  final TextEditingController _businessEmailAddressController =
      TextEditingController();
  final TextEditingController _businessPhoneNumberController =
      TextEditingController();
  final TextEditingController _businessAddressController =
      TextEditingController();

  String? _businessId;
  String? _selectedCategory;

  bool _isActiveController = true;
  File? _bannerImage;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void dispose() {
    _businessNameController.dispose();
    _businessDescriptionController.dispose();
    _businessEmailAddressController.dispose();
    _businessPhoneNumberController.dispose();
    _businessAddressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<BusinessBloc>().add(GetBusinessEvent());
    context.read<BusinessCategoryBloc>().add(GetBusinessCategoriesEvent());
  }

  Future<void> _pickBannerImage() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _bannerImage = File(pickedFile.path);
      });
    }
  }

  void _onUpdateBusiness() {
    if (_formKey.currentState!.validate() && _businessId != null) {
      context.read<BusinessBloc>().add(
        UpdateBusinessEvent(
          id: _businessId!,
          name: _businessNameController.text,
          description: _businessDescriptionController.text,
          address: _businessAddressController.text,
          emailAddress: _businessEmailAddressController.text,
          phoneNumber: _businessPhoneNumberController.text,
          bannerImage: _bannerImage,
          isActive: _isActiveController,
          categoryName: _selectedCategory,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/user_profile');
          },
        ),
        iconTheme: const IconThemeData(color: DefaultColors.background),
        backgroundColor: DefaultColors.primary,
        centerTitle: true,
        title: const Text(
          'Update Business',
          style: TextStyle(
            color: DefaultColors.background,
            fontSize: FontSize.headingMedium,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<BusinessBloc, BusinessState>(
          listener: (context, state) {
            if (state is BusinessError) {
              CustomSnackBar.show(
                message: state.errorMessage,
                context: context,
                isError: true,
              );
            } else if (state is BusinessUpdateError) {
              CustomSnackBar.show(
                message: state.errorMessage,
                context: context,
                isError: true,
              );
            } else if (state is BusinessLoaded) {
              if (_businessId == null) {
                _businessId = state.data.id;
                _businessNameController.text = state.data.name;
                _businessDescriptionController.text = state.data.description;
                _businessEmailAddressController.text = state.data.emailAddress;
                _businessPhoneNumberController.text = state.data.phoneNumber;
                _businessAddressController.text = state.data.address;
                _selectedCategory = state.data.categoryName;
                _isActiveController = state.data.isActive;
              }
            } else if (state is BusinessUpdateLoaded) {
              CustomSnackBar.show(
                message: state.message,
                context: context,
                isError: false,
              );
              Navigator.of(context).pushReplacementNamed('/user_profile');
            }
          },
          builder: (context, state) {
            if (state is BusinessLoading && _businessId == null) {
              return const AnimatedLoadingPage(
                message: 'Loading business details...',
              );
            }

            if (state is BusinessUpdateLoading) {
              return const AnimatedLoadingPage(message: 'Updating Business...');
            }

            if (_businessId != null) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      CustomFormField(
                        controller: _businessNameController,
                        labelText: 'Business Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a business name';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        icon: Icons.business,
                        readOnly: false,
                      ),
                      CustomFormField(
                        controller: _businessDescriptionController,
                        labelText: 'Business Description',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        icon: Icons.description,
                        readOnly: false,
                      ),
                      CustomFormField(
                        controller: _businessAddressController,
                        labelText: "Business address",
                        icon: Icons.location_on,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an address';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.streetAddress,
                        obscureText: false,
                        readOnly: false,
                      ),
                      CustomFormField(
                        controller: _businessEmailAddressController,
                        labelText: "Business email address",
                        icon: Icons.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        readOnly: false,
                      ),
                      CustomFormField(
                        controller: _businessPhoneNumberController,
                        labelText: "Business phone number",
                        icon: Icons.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                        readOnly: false,
                      ),

                      BlocBuilder<BusinessCategoryBloc, BusinessCategoryState>(
                        builder: (context, categoryState) {
                          if (categoryState is BusinessCategoryLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (categoryState is BusinessCategoryLoaded) {
                            final categories = categoryState.data ?? [];

                            final isValidCategory =
                                _selectedCategory != null &&
                                categories.any(
                                  (cat) => cat.name == _selectedCategory,
                                );

                            return CustomDropdownField<String>(
                              labelText: 'Business Category',
                              icon: Icons.category,
                              value: isValidCategory ? _selectedCategory : null,
                              items: categories.map((category) {
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a business category';
                                }
                                return null;
                              },
                            );
                          }

                          if (categoryState is BusinessCategoryError) {
                            return Text(
                              'Error loading categories: ${categoryState.errorMessage}',
                              style: const TextStyle(color: Colors.red),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 5,
                        ),
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
                                          _bannerImage = null;
                                        });
                                      },
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Button(
                        buttonText: 'Update Business',
                        isIconButton: false,
                        onPressed: _onUpdateBusiness,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
