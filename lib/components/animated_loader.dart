import 'package:campus_cart/core/theme/theme.dart';
import 'package:flutter/material.dart';

class AnimatedLoadingPage extends StatefulWidget {
  final String message;

  const AnimatedLoadingPage({
    super.key,
    this.message = 'Loading Campus Cart...',
  });

  @override
  State<AnimatedLoadingPage> createState() => _AnimatedLoadingPageState();
}

class _AnimatedLoadingPageState extends State<AnimatedLoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: DefaultColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shopping_cart_rounded,
                  size: 80,
                  color: DefaultColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 32),

            Text(
              widget.message,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: DefaultColors.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),

            const SizedBox(
              width: 150,
              child: LinearProgressIndicator(
                backgroundColor: DefaultColors.gray,
                color: DefaultColors.primary,
                minHeight: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
