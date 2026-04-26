// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_core/providers/03_D_portal_providers.dart';
import 'package:primecare_ui/src/theme/01_I_design_system.dart';

/// [PrimeCareAvatar] is a high-fidelity, registry-aware avatar component.
/// It automatically scales based on the [layoutProvider] and uses the [PrimeCareDesignSystem].
class PrimeCareAvatar extends ConsumerWidget {
  final String? imageUrl;
  final String fallbackInitials;
  final double radius;
  final bool isOnline;
  final Color? backgroundColor;

  const PrimeCareAvatar({
    super.key,
    this.imageUrl,
    required this.fallbackInitials,
    this.radius = 24.0,
    this.isOnline = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;
    final ds = PrimeCareDesignSystem.of(context);

    final scaledRadius = radius * scale;
    final fallbackBg =
        backgroundColor ?? ds.colors.primary.withValues(alpha: 0.1);
    final textColor = ds.colors.primary;

    return Stack(
      children: [
        Container(
          width: scaledRadius * 2,
          height: scaledRadius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: fallbackBg,
            image: imageUrl != null
                ? DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
            border: Border.all(
              color: ds.colors.borderSubtle.withValues(alpha: 0.5),
              width: 1.0 * scale,
            ),
          ),
          child: imageUrl == null
              ? Center(
                  child: Text(
                    fallbackInitials.toUpperCase(),
                    style: GoogleFonts.outfit(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: (radius * 0.8) * scale,
                    ),
                  ),
                )
              : null,
        ),
        if (isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: (radius * 0.5) * scale,
              height: (radius * 0.5) * scale,
              decoration: BoxDecoration(
                color: ds.colors.success,
                shape: BoxShape.circle,
                border: Border.all(
                  color: ds.colors.surface,
                  width: 2.0 * scale,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4 * scale,
                    offset: Offset(0, 2 * scale),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
