import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:campus_cart/components/toggle.dart';
import 'package:campus_cart/components/snackbar.dart';
import 'package:campus_cart/components/animated_loader.dart';
import 'package:campus_cart/features/business/domain/entities/product_entity.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_bloc.dart';
import 'package:campus_cart/components/button.dart'; // Ensure you import your button
import 'package:campus_cart/features/business/presentation/bloc/business_state.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_event.dart';
import 'package:campus_cart/components/form.dart'; // Ensure you import your form field

class EditProduct extends StatefulWidget {
  const EditProduct({super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  bool _isInit = true;
  ProductEntity? _initialProduct;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _stockCountController;
  late bool _isAvailableController;
  // Removed the stray "String" declaration here

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      final productArgument = ModalRoute.of(context)?.settings.arguments;
      if (productArgument is ProductEntity) {
        _initialProduct = productArgument;

        _isAvailableController = _initialProduct!.isAvailable;
        _stockCountController = TextEditingController(
          text: _initialProduct?.stockCount.toString(),
        );

        context.read<BusinessBloc>().add(
          GetBusinessProductByIdEvent(productId: _initialProduct!.id),
        );
      }
      _isInit = false;
    }
  }

  @override
  void dispose() {
    _stockCountController.dispose();
    super.dispose();
  }

  void onUpdateProduct() {
    if (_formKey.currentState!.validate() && _initialProduct?.id != null) {
      context.read<BusinessBloc>().add(
        UpdateBusinessProductByIdEvent(
          productId: _initialProduct!.id,
          isAvailable: _isAvailableController,
          stockCount: int.tryParse(_stockCountController.text) ?? 0,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initialProduct == null) {
      return Scaffold(
        appBar: AppBar(backgroundColor: DefaultColors.primary),
        body: const Center(child: Text("Product not found")),
      );
    }

    return Scaffold(
      backgroundColor: DefaultColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        iconTheme: const IconThemeData(color: DefaultColors.background),
        backgroundColor: DefaultColors.primary,
        centerTitle: true,
        title: const Text(
          'Edit Product Details',
          style: TextStyle(
            color: DefaultColors.background,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<BusinessBloc, BusinessState>(
          listener: (context, state) {
            // if (state is BusinessProductByIdLoaded) {
            //   final product = state.data;
            //   if (product.id == _initialProduct!.id) {
            //     // Update state if needed
            //   }
            // }

            // if (state is UpdateBusinessProductByIdLoaded) {
            //   CustomSnackBar.show(
            //     context: context,
            //     message: state.message,
            //     isError: false,
            //   );

            //   Navigator.of(context).pushReplacementNamed('/business_products');
            // }

            if (state is BusinessProductByIdError) {
              CustomSnackBar.show(
                context: context,
                message: state.errorMessage,
                isError: true,
              );
            } else if (state is UpdateBusinessProductByIdError) {
              CustomSnackBar.show(
                context: context,
                message: state.errorMessage,
                isError: false,
              );
            } else if (state is BusinessProductByIdLoaded) {
              if (_initialProduct?.id == null) {
                _isAvailableController = _initialProduct!.isAvailable;
                _stockCountController = TextEditingController(
                  text: _initialProduct!.stockCount.toString(),
                );
              }
            } else if (state is UpdateBusinessProductByIdLoaded) {
              CustomSnackBar.show(
                context: context,
                message: state.message,
                isError: false,
              );
              Navigator.of(context).pushReplacementNamed('/business_products');
            }
          },
          builder: (context, state) {
            if (state is BusinessProductByIdLoading ||
                state is UpdateBusinessProductByIdLoading) {
              return AnimatedLoadingPage(message: "Loading product...");
            }

            if (state is UpdateBusinessProductByIdLoading) {
              return AnimatedLoadingPage(message: 'Updating product');
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFormField(
                      icon: Icons.inventory_2_outlined,
                      controller: _stockCountController,
                      labelText: "Stock Count",
                      keyboardType: TextInputType.number,
                      readOnly: false,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Stock count is required";
                        }
                        if (int.tryParse(value) == null) {
                          return "Please enter a valid number";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Product Availability",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        CustomToggle(
                          isActive: _isAvailableController,
                          onChanged: ((value) {
                            setState(() {
                              _isAvailableController = value;
                            });
                          }),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Button(
                      buttonText: 'Update Product',
                      isIconButton: false,
                      onPressed: onUpdateProduct,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
