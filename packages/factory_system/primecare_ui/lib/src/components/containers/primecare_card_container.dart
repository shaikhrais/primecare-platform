import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';

class PrimeCareCardContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const PrimeCareCardContainer({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PrimeCareColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: PrimeCareColors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: padding != null ? Padding(padding: padding!, child: child) : child,
    );
  }
}
