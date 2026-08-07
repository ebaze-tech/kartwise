import 'package:campus_cart/components/button.dart';
import 'package:campus_cart/components/dropdown.dart';
import 'package:campus_cart/components/form.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BusinessOwner extends StatefulWidget {
  const BusinessOwner({super.key});

  @override
  State<BusinessOwner> createState() => _BusinessOwnerState();
}

class _BusinessOwnerState extends State<BusinessOwner> {
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
  /*  final TextEditingController _businessWebsiteController =
      TextEditingController();
  final TextEditingController _businessSocialMediaController =
      TextEditingController();
  final TextEditingController _businessHoursController =
      TextEditingController();
  final TextEditingController _businessLogoController = TextEditingController();
  final TextEditingController _businessBannerController =
      TextEditingController();
  final TextEditingController _businessPaymentMethodsController =
      TextEditingController();
  final TextEditingController _businessDeliveryOptionsController =
      TextEditingController();
      */

  @override
  void dispose() {
    _businessNameController.dispose();
    _businessAddressController.dispose();
    _businessPhoneController.dispose();
    _businessEmailController.dispose();
    _businessDescriptionController.dispose();
    _businessCategoryController.dispose();
    /* _businessWebsiteController.dispose();
    _businessSocialMediaController.dispose();
    _businessHoursController.dispose();
    _businessLogoController.dispose();
    _businessBannerController.dispose();
    _businessPaymentMethodsController.dispose();
    _businessDeliveryOptionsController.dispose();
    */
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
              height: 30,
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 5),
            Text(
              'KartWise',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Register Your Business',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.start,
                  ),
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
                    labelTextStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  CustomFormField(
                    icon: Icons.info,
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
                    labelTextStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  CustomDropdownField<String>(
                    labelText: "Business Category",
                    icon: Icons.category,
                    value: _selectedCategory,
                    items: const [
                      DropdownMenuItem(value: 'FOOD', child: Text('Food')),
                      DropdownMenuItem(
                        value: 'CLOTHING',
                        child: Text('Clothing'),
                      ),
                      DropdownMenuItem(
                        value: 'ELECTRONICS',
                        child: Text('Electronics'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
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
                    labelTextStyle: Theme.of(context).textTheme.bodyMedium,
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
                    labelTextStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  // SizedBox(height: 5),
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
                    labelTextStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 20),
                  Button(
                    buttonText: "Register",
                    isIconButton: false,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
