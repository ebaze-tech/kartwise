import 'package:campus_cart/components/animated_loader.dart';
import 'package:campus_cart/components/button.dart';
import 'package:campus_cart/components/error.dart';
import 'package:campus_cart/components/floating_action.dart';
import 'package:campus_cart/components/snackbar.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_bloc.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_event.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BusinessBloc>().add(GetBusinessProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/business_dashboard");
          },
          icon: const Icon(Icons.arrow_back),
        ),
        iconTheme: const IconThemeData(color: DefaultColors.background),
        backgroundColor: DefaultColors.primary,
        centerTitle: true,
        title: const Text(
          'Business Products',
          style: TextStyle(
            color: DefaultColors.background,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<BusinessBloc, BusinessState>(
        listener: (context, state) {
          if (state is BusinessProductsError) {
            CustomSnackBar.show(
              context: context,
              message: state.errorMessage,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          if (state is BusinessProductsLoading) {
            return const Center(
              child: AnimatedLoadingPage(message: "Loading products..."),
            );
          }
          if (state is BusinessProductsLoaded &&
              (state.data == null || state.data?.isEmpty == true)) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: DefaultColors.primary.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.remove_shopping_cart,
                      size: 55,
                      color: DefaultColors.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "No products yet",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: DefaultColors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Add some products to start selling",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  Button(
                    buttonText: "Add Product",
                    isIconButton: false,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/add_product').then((_) {
                        context.read<BusinessBloc>().add(
                          GetBusinessProductsEvent(),
                        );
                      });
                    },
                  ),
                ],
              ),
            );
          }

          if (state is BusinessProductsLoaded &&
              state.data?.isNotEmpty == true) {
            return Column(
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final product = state.data?[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(
                            context,
                          ).pushNamed('/product_details', arguments: product);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: DefaultColors.background,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Product Image
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child:
                                            product?.images != null &&
                                                product!.images!.isNotEmpty
                                            ? Image.network(
                                                product.images!.first.url,
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                              )
                                            : Container(
                                                width: 80,
                                                height: 80,
                                                color: Colors.grey[200],
                                                child: const Icon(
                                                  Icons.image_not_supported,
                                                ),
                                              ),
                                      ),
                                      const SizedBox(width: 12),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    product?.name ?? 'Unknown',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  "₦${product?.price ?? 0}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DefaultColors
                                                            .primary,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 6),

                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: (product!.isAvailable)
                                                    ? Colors.green
                                                    : Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                (product.isAvailable)
                                                    ? 'Available'
                                                    : 'Unavailable',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: DefaultColors
                                                          .background,
                                                    ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),

                                            Text(
                                              product?.description ?? '',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodySmall,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "Category: ${product?.productCategoryName ?? 'None'}",
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodySmall,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Button(
                                    buttonText: "View Details",
                                    isIconButton: false,
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                        '/product_details',
                                        arguments: product,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return Center(
            child: CustomError(
              message: 'Failed to load products',
              onRetry: () {
                context.read<BusinessBloc>().add(GetBusinessProductsEvent());
              },
            ),
          );
        },
      ),
      floatingActionButton: BlocBuilder<BusinessBloc, BusinessState>(
        builder: (context, state) {
          if (state is BusinessProductsLoaded &&
              state.data?.isNotEmpty == true) {
            return FloatingAction(
              onPressed: () {
                Navigator.of(context).pushNamed('/add_product');
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
