// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';

class FallbackStateWrapper extends StatelessWidget {
  final bool isOfflineFallback;
  final Widget child;

  const FallbackStateWrapper({
    super.key,
    required this.isOfflineFallback,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!isOfflineFallback) {
      return child;
    }

    return Banner(
      message: 'MOCK DATA',
      location: BannerLocation.topStart,
      color: PrimeCareColors.amber,
      textStyle: const TextStyle(
        color: PrimeCareColors.white,
        fontSize: 10,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
      child: ColorFiltered(
        // Slightly tint the entire screen to indicate it's not live
        colorFilter: ColorFilter.mode(
          PrimeCareColors.amber.withValues(alpha: 0.05),
          BlendMode.srcOver,
        ),
        child: child,
      ),
    );
  }
}
