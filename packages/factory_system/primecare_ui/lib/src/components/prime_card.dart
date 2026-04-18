import 'package:primecare_ui/src/theme/colors.dart';
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
        color: PrimeCareColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isFlat
            ? []
            : [
                BoxShadow(
                  color: PrimeCareColors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
        border: isFlat ? Border.all(color: PrimeCareColors.slate400) : null,
      ),
      child: child,
    );
  }
}
