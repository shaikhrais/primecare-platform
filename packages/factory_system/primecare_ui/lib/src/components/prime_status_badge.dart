import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/providers/portal_providers.dart';
import '../theme/design_system.dart';

enum BadgeType {
  success,
  danger,
  warning,
  info,
  neutral;

  Color color(PrimeCareDesignSystem ds) {
    switch (this) {
      case BadgeType.success:
        return ds.colors.success;
      case BadgeType.danger:
        return ds.colors.danger;
      case BadgeType.warning:
        return ds.colors.warning;
      case BadgeType.info:
        return ds.colors.info;
      case BadgeType.neutral:
        return ds.colors.textSecondary;
    }
  }

  Color background(PrimeCareDesignSystem ds) {
    switch (this) {
      case BadgeType.success:
        return ds.colors.successSurface;
      case BadgeType.danger:
        return ds.colors.dangerSurface;
      case BadgeType.warning:
        return ds.colors.warningSurface;
      case BadgeType.info:
        return ds.colors.infoSurface;
      case BadgeType.neutral:
        return ds.colors.borderSubtle.withValues(alpha: 0.5);
    }
  }
}

class PrimeStatusBadge extends ConsumerWidget {
  final String? text;
  final String? label; // Alias for text for compatibility
  final BadgeType type;
  final Color? color; // Legacy support

  const PrimeStatusBadge({
    super.key,
    this.text,
    this.label,
    this.type = BadgeType.neutral,
    this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;
    final ds = PrimeCareDesignSystem.of(context);

    final String displayText = text ?? label ?? 'STATUS';

    // Fallback logic for legacy color or neutral type
    final textColor = color ?? type.color(ds);
    final bgColor = color != null
        ? color!.withValues(alpha: 0.1)
        : type.background(ds);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: PrimeCareSpacing.scaled(8, scale).toDouble(),
        vertical: PrimeCareSpacing.scaled(4, scale).toDouble(),
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(
          PrimeCareSpacing.scaled(8, scale).toDouble(),
        ),
        border: Border.all(
          color: textColor.withValues(alpha: 0.2),
          width: 1.0 * scale,
        ),
      ),
      child: Text(
        displayText.toUpperCase(),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: GoogleFonts.outfit(
          color: textColor,
          fontSize: PrimeCareSpacing.scaled(11, scale).toDouble(),
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5 * scale,
        ),
      ),
    );
  }
}
