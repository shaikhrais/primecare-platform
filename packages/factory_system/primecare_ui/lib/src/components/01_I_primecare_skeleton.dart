// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/providers/03_D_portal_providers.dart';
import 'package:primecare_ui/src/theme/01_I_design_system.dart';

/// [PrimeCareSkeleton] provides a high-fidelity loading placeholder.
/// It respects the [layoutProvider] scale factor and [PrimeCareDesignSystem] tokens.
class PrimeCareSkeleton extends ConsumerWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final BoxShape shape;

  const PrimeCareSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8.0,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;
    final ds = PrimeCareDesignSystem.of(context);

    return Container(
      width: width != null ? width! * scale : null,
      height: height != null ? height! * scale : null,
      decoration: BoxDecoration(
        shape: shape,
        borderRadius: shape == BoxShape.rectangle 
            ? BorderRadius.circular(borderRadius * scale) 
            : null,
        gradient: LinearGradient(
          colors: [
            ds.colors.borderSubtle.withValues(alpha: 0.5),
            ds.colors.borderSubtle.withValues(alpha: 0.8),
            ds.colors.borderSubtle.withValues(alpha: 0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
