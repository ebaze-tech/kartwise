import 'package:flutter/material.dart';
import 'dart:math';

class GradientSpinner extends StatefulWidget {
  final double size;
  final double strokeWidth;

  const GradientSpinner({
    super.key, 
    this.size = 48.0, // Matches standard button heights
    this.strokeWidth = 4.0,
  });

  @override
  State<GradientSpinner> createState() => _GradientSpinnerState();
}

class _GradientSpinnerState extends State<GradientSpinner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Rotates smoothly 360 degrees every 1 second
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(); 
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: CustomPaint(
          painter: _GradientSpinnerPainter(
            color: Theme.of(context).primaryColor,
            strokeWidth: widget.strokeWidth,
          ),
        ),
      ),
    );
  }
}

class _GradientSpinnerPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _GradientSpinnerPainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    
    final Paint paint = Paint()
      ..shader = SweepGradient(
        colors: [
          color.withValues(alpha: 0.0), // Fades out smoothly
          color, // Solid primary color at the head
        ],
        stops: const [0.0, 1.0],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Deflate prevents the stroke from being clipped at the edges of the box
    canvas.drawArc(
      rect.deflate(strokeWidth / 2), 
      0.0,
      pi * 2,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}