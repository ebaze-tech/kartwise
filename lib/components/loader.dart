import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SleekLoader extends StatefulWidget {
  const SleekLoader({super.key});

  @override
  State<SleekLoader> createState() => _SleekLoaderState();
}

class _SleekLoaderState extends State<SleekLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // 1. Set up the controller to loop back and forth infinitely
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    // 2. Define the scale (grows from 80% to 110%)
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // 3. Define the opacity (fades between 50% and 100%)
    _fadeAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Logo
            FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                  height: 80,
                  // Uses the primary color from your theme
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // App Name
            Text(
              'PeerPlaza',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).primaryColor,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 40),

            // Delicate Spinner
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
