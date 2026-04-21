// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primecare_core/providers/03_D_portal_providers.dart';

import 'package:primecare_ui/src/theme/01_I_design_system.dart';

class PrimeCareStatCard extends ConsumerWidget {
  final String title;
  final String value;
  final double? delta;
  final String? deltaSuffix;
  final IconData? icon;
  final Color? iconColor;

  const PrimeCareStatCard({
    super.key,
    required this.title,
    required this.value,
    this.delta,
    this.deltaSuffix,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;
    final ds = PrimeCareDesignSystem.of(context);
    final isPositive = (delta ?? 0) >= 0;

    return Container(
      padding: EdgeInsets.all(PrimeCareSpacing.lg * scale),
      decoration: BoxDecoration(
        color: ds.colors.surface,
        borderRadius: BorderRadius.circular(PrimeCareRadii.lg * scale),
        border: Border.all(color: ds.colors.borderSubtle, width: 1.5 * scale),
        boxShadow: [
          BoxShadow(
            color: ds.colors.shadow,
            blurRadius: 10 * scale,
            offset: Offset(0, 4 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.inter(
                    color: ds.colors.textSecondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12 * scale,
                    letterSpacing: 1.2 * scale,
                  ),
                ),
              ),
              if (icon != null)
                Icon(
                  icon,
                  color: iconColor ?? ds.colors.primary,
                  size: 20 * scale,
                ),
            ],
          ),
          SizedBox(height: PrimeCareSpacing.md * scale),
          Text(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: GoogleFonts.outfit(
              fontSize: 32 * scale,
              fontWeight: FontWeight.bold,
              color: ds.colors.textPrimary,
              letterSpacing: -0.5 * scale,
            ),
          ),
          if (delta != null) ...[
            SizedBox(height: PrimeCareSpacing.sm * scale),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8 * scale,
                    vertical: 4 * scale,
                  ),
                  decoration: BoxDecoration(
                    color: isPositive
                        ? ds.colors.successSurface
                        : ds.colors.dangerSurface,
                    borderRadius: BorderRadius.circular(
                      PrimeCareRadii.sm * scale,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPositive
                            ? Icons.trending_up_rounded
                            : Icons.trending_down_rounded,
                        size: 14 * scale,
                        color: isPositive
                            ? ds.colors.success
                            : ds.colors.danger,
                      ),
                      SizedBox(width: 4 * scale),
                      Text(
                        '${delta!.abs().toStringAsFixed(1)}%',
                        style: GoogleFonts.inter(
                          fontSize: 12 * scale,
                          fontWeight: FontWeight.bold,
                          color: isPositive
                              ? ds.colors.success
                              : ds.colors.danger,
                        ),
                      ),
                    ],
                  ),
                ),
                if (deltaSuffix != null) ...[
                  SizedBox(width: PrimeCareSpacing.xs * scale),
                  Text(
                    deltaSuffix!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.inter(
                      fontSize: 12 * scale,
                      color: ds.colors.textTertiary,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
