import 'dart:async';
import 'package:flutter/material.dart';
import 'package:campus_cart/core/theme/theme.dart';

class ProductImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final double height;
  final PageController? controller;
  final ValueChanged<int>? onPageChanged;

  const ProductImageCarousel({
    super.key,
    required this.imageUrls,
    this.height = 300,
    this.controller,
    this.onPageChanged,
  });

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  late PageController _pageController;

  Timer? _autoSlideTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController = widget.controller ?? PageController();

    _startAutoSlide();
  }

  void _startAutoSlide() {
    if (widget.imageUrls.length <= 1) return;

    _autoSlideTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_pageController.hasClients) return;

      final nextPage = (_currentPage + 1) % widget.imageUrls.length;

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    if (widget.controller == null) {
      _pageController.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) {
      return Container(
        height: widget.height,
        color: DefaultColors.gray,
        child: const Center(
          child: Icon(Icons.image_not_supported, size: 80, color: Colors.white),
        ),
      );
    }

    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
              if (widget.onPageChanged != null) {
                widget.onPageChanged!(index);
              }
            },
            itemBuilder: (context, index) {
              return Image.network(
                widget.imageUrls[index],
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }

                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: DefaultColors.gray,
                    child: const Center(
                      child: Icon(
                        Icons.broken_image_outlined,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              );
            },
          ),

          // Gradient overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black54, Colors.transparent, Colors.black26],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),
          ),

          if (widget.imageUrls.length > 1)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.imageUrls.length, (index) {
                  final isActive = index == _currentPage;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: isActive ? 24 : 8,
                    decoration: BoxDecoration(
                      color: isActive ? DefaultColors.primary : Colors.white70,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}
