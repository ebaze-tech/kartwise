import 'package:campus_cart/core/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomToggle extends StatelessWidget {
  final bool isActive;
  final ValueChanged<bool> onChanged;

  const CustomToggle({
    super.key,
    required this.isActive,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isActive),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 220,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: isActive ? DefaultColors.primary : Colors.grey.shade300,
        ),
        child: Stack(
          children: [
            // 1. The Sliding White Thumb
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: isActive
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: 105, // Half the width minus padding
                  height: 37,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Row(
              children: [
                // Inactive Side
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cancel_rounded,
                          size: 18,
                          color: isActive ? Colors.white70 : Colors.black87,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Inactive',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: isActive
                                    ? Colors.white70
                                    : Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          size: 18,
                          color: isActive ? Colors.black87 : Colors.black45,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Active',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: isActive
                                    ? Colors.black87
                                    : Colors.black45,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
