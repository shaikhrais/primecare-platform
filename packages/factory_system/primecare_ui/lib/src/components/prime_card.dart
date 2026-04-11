import 'package:flutter/material.dart';

class PrimeCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool isFlat;

  const PrimeCard({
    super.key,
    required this.child,
    this.padding,
    this.isFlat = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isFlat
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
        border: isFlat ? Border.all(color: Colors.grey.shade200) : null,
      ),
      child: child,
    );
  }
}
