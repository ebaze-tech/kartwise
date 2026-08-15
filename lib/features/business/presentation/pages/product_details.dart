import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_cart/components/error.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:campus_cart/components/button.dart';
import 'package:campus_cart/components/carousel.dart';
import 'package:campus_cart/components/snackbar.dart';
import 'package:campus_cart/components/animated_loader.dart';
import 'package:campus_cart/features/business/domain/entities/product_entity.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_bloc.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_event.dart';
import 'package:campus_cart/features/business/presentation/bloc/business_state.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _isInit = true;
  ProductEntity? _initialProduct;

  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoSlideTimer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      final productArgument = ModalRoute.of(context)?.settings.arguments;
      if (productArgument is ProductEntity) {
        _initialProduct = productArgument;

        context.read<BusinessBloc>().add(
          GetBusinessProductByIdEvent(productId: _initialProduct!.id),
        );
      }
      _isInit = false;
    }
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_initialProduct == null) {
      return Scaffold(
        appBar: AppBar(backgroundColor: DefaultColors.primary),
        body: const Center(child: Text('Product not found')),
      );
    }

    void startAutoSlide(int imageCount) {
      if (imageCount <= 1) return;

      _autoSlideTimer?.cancel();

      _autoSlideTimer = Timer.periodic(const Duration(seconds: 5), (_) {
        if (!_pageController.hasClients) return;

        int nextPage = _currentPage + 1;

        if (nextPage >= imageCount) {
          nextPage = 0;
        }

        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOut,
        );
      });
    }

    return Scaffold(
      backgroundColor: DefaultColors.background,
      body: BlocConsumer<BusinessBloc, BusinessState>(
        builder: (context, state) {
          ProductEntity displayedProduct = _initialProduct!;

          if (state is BusinessProductByIdLoading) {
            return const AnimatedLoadingPage(
              message: "Loading product details...",
            );
          }

          if (state is BusinessProductByIdLoaded) {
            displayedProduct = state.data;
            final imageCount = displayedProduct.images?.length ?? 0;

            // ✅ Trigger the auto-slider once we have the data
            startAutoSlide(imageCount);

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  backgroundColor: DefaultColors.primary,
                  leading: IconButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/business_products'),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: DefaultColors.background,
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: ProductImageCarousel(
                      imageUrls:
                          displayedProduct.images
                              ?.map((image) => image.url)
                              .toList() ??
                          [],
                      height: 300,
                      controller: _pageController,
                      onPageChanged: (index) {
                        _currentPage = index;
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: displayedProduct.isAvailable
                                    ? Colors.green
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                displayedProduct.isAvailable
                                    ? 'Available'
                                    : 'Unavailable',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: DefaultColors.lightGray),
                              ),
                            ),
                            Text(
                              displayedProduct.productCategoryName,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          displayedProduct.name,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "₦${displayedProduct.price}",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: DefaultColors.primary,
                              ),
                        ),
                        const SizedBox(height: 10),

                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.inventory_2_outlined,
                              color: DefaultColors.gray,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Stock Remaining: ",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Text(
                              " ${displayedProduct.stockCount} units",
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: DefaultColors.primary,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Description",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          displayedProduct.description,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 30),
                        Button(
                          buttonText: "Edit Product",
                          isIconButton: false,
                          onPressed: () {
                            // print(displayedProduct.id);
                            Navigator.of(context).pushNamed(
                              '/edit_product',
                              arguments: displayedProduct,
                            );
                          },
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(
            child: CustomError(
              message: 'Failed to load product detail',
              onRetry: () {
                context.read<BusinessBloc>().add(
                  GetBusinessProductByIdEvent(productId: _initialProduct!.id),
                );
              },
            ),
          );
        },
        listener: (context, state) {
          if (state is BusinessProductByIdError) {
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
}
