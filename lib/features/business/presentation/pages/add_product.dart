import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:campus_cart/components/form.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:campus_cart/components/button.dart';
import 'package:campus_cart/components/toggle.dart';
import 'package:campus_cart/components/dropdown.dart';
import 'package:campus_cart/components/snackbar.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_bloc.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_event.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_state.dart';
import 'package:campus_cart/features/business/presentation/bloc/categories_bloc.dart';
import 'package:campus_cart/features/business/presentation/bloc/categories_state.dart';
import 'package:campus_cart/features/business/presentation/bloc/categories_event.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _stockCountController = TextEditingController();

  String? _selectedProductCategory;
  bool _isAvailableController = true;

  final List<File> _productImages = [];
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void dispose() {
    _productNameController.dispose();
    _productDescriptionController.dispose();
    _productPriceController.dispose();
    _stockCountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<ProductCategoriesBloc>().add(GetProductCategoriesEvent());
  }

  Future<void> _pickImages() async {
    if (_productImages.length >= 5) {
      CustomSnackBar.show(
        message: 'You can only upload a maximum of 5 images.',
        context: context,
        isError: true,
      );
      return;
    }

    final pickedFiles = await _imagePicker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      setState(() {
        for (var file in pickedFiles) {
          if (_productImages.length < 5) {
            _productImages.add(File(file.path));
          }
        }
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _productImages.removeAt(index);
    });
  }

  void _submitProduct() {
    if (_formKey.currentState!.validate()) {
      // print('isAvailable before request: $_isAvailableController');
      if (_selectedProductCategory == null ||
          _selectedProductCategory!.isEmpty) {
        CustomSnackBar.show(
          message: 'Please select a product category.',
          context: context,
          isError: true,
        );
        return;
      }

      if (_productImages.isEmpty) {
        CustomSnackBar.show(
          message: 'Add at least one product image.',
          context: context,
          isError: true,
        );
        return;
      }

      context.read<BusinessBloc>().add(
        CreateProductEvent(
          name: _productNameController.text.trim(),
          description: _productDescriptionController.text.trim(),
          price: double.parse(_productPriceController.text.trim()),
          stockCount: int.parse(_stockCountController.text.trim()),
          productCategoryName: _selectedProductCategory!,
          isAvailable: _isAvailableController,
          images: _productImages,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () =>
              Navigator.of(context).pushNamed('/business_products'),
          icon: const Icon(Icons.arrow_back, color: DefaultColors.whiteText),
        ),
        backgroundColor: DefaultColors.primary,
        title: Text(
          'Create Product',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: DefaultColors.whiteText,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<BusinessBloc, BusinessState>(
        builder: (context, state) {
          final isLoading = state is CreateProductLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSectionCard(
                    context: context,
                    title: 'Product Details',
                    items: [
                      CustomFormField(
                        controller: _productNameController,
                        labelText: 'Product Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Product name is required";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        icon: Icons.inventory_2_outlined,
                        readOnly: false,
                      ),
                      CustomFormField(
                        controller: _productDescriptionController,
                        labelText: 'Product Description',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Product description is required";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        icon: Icons.description,
                        readOnly: false,
                      ),
                      CustomFormField(
                        controller: _productPriceController,
                        labelText: 'Product Price (₦)',
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              double.tryParse(value) == null) {
                            return 'Please enter a valid price';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        icon: Icons.price_change_outlined,
                        readOnly: false,
                      ),
                      BlocBuilder<
                        ProductCategoriesBloc,
                        ProductCategoriesState
                      >(
                        builder: (context, catState) {
                          if (catState is ProductCategoriesError) {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          if (catState is ProductCategoriesLoaded) {
                            return CustomDropdownField<String>(
                              labelText: "Product Category",
                              icon: Icons.category_outlined,
                              value: _selectedProductCategory,
                              items: catState.data!.map((category) {
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
                                  _selectedProductCategory = value;
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
                    title: 'Product Images (${_productImages.length}/5)',
                    trailingHeader: IconButton(
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: DefaultColors.primary,
                      ),
                      onPressed: _pickImages,
                    ),
                    items: [
                      if (_productImages.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Center(
                            child: Text(
                              'No images added yet.\nTap the icon above to upload.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      else
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(12),
                            itemCount: _productImages.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: DefaultColors.neutral,
                                      ),
                                      image: DecorationImage(
                                        image: FileImage(_productImages[index]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 16,
                                    child: GestureDetector(
                                      onTap: () => _removeImage(index),
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: Colors.black54,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _buildSectionCard(
                    context: context,
                    title: 'Inventory & Availability',
                    items: [
                      CustomFormField(
                        controller: _stockCountController,
                        labelText: 'Stock Count',
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null) {
                            return 'Valid stock count required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        icon: Icons.production_quantity_limits_outlined,
                        readOnly: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Product Status',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            CustomToggle(
                              isActive: _isAvailableController,
                              onChanged: (value) {
                                setState(() {
                                  _isAvailableController = value;
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
                    buttonText: isLoading ? "Creating..." : "Create Product",
                    isIconButton: false,
                    onPressed: isLoading ? () {} : _submitProduct,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is CreateProductLoaded) {
            CustomSnackBar.show(
              context: context,
              message: state.message,
              isError: false,
            );
            Navigator.of(context).pushNamed('/business_products');
          }
          if (state is CreateProductError) {
            CustomSnackBar.show(
              context: context,
              message: state.errorMessage,
              isError: true,
            );
          }
        },
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
              top: 8,
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
}
