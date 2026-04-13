import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/providers/portal_providers.dart';
import '../theme/theme_tokens.dart';
import '../theme/design_system.dart';

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
    final isPositive = (delta ?? 0) >= 0;

    return Container(
      padding: EdgeInsets.all(PrimeCareSpacing.lg * scale),
      decoration: BoxDecoration(
        color: PrimeCareDesignSystem.surfaceElevated,
        borderRadius: BorderRadius.circular(PrimeCareRadii.lg * scale),
        border: Border.all(color: PrimeCareDesignSystem.borderSubtle, width: 1),
        boxShadow: const [PrimeCareShadows.soft],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: PrimeCareDesignSystem.textMuted,
                  fontWeight: FontWeight.w600,
                  fontSize:
                      (Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14) *
                      scale,
                ),
              ),
              if (icon != null)
                Icon(
                  icon,
                  color: PrimeCareDesignSystem.textMuted,
                  size: 20 * scale,
                ),
            ],
          ),
          SizedBox(height: PrimeCareSpacing.md * scale),
          Text(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize:
                  (Theme.of(context).textTheme.headlineMedium?.fontSize ?? 24) *
                  scale,
            ),
          ),
          if (delta != null) ...[
            SizedBox(height: PrimeCareSpacing.sm * scale),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: PrimeCareSpacing.xs * scale,
                    vertical: 2 * scale,
                  ),
                  decoration: BoxDecoration(
                    color: isPositive
                        ? PrimeCareDesignSystem.successSurface
                        : PrimeCareDesignSystem.dangerSurface,
                    borderRadius: BorderRadius.circular(
                      PrimeCareRadii.sm * scale,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isPositive
                            ? Icons.arrow_upward_rounded
                            : Icons.arrow_downward_rounded,
                        size: 12 * scale,
                        color: isPositive
                            ? PrimeCareDesignSystem.successText
                            : PrimeCareDesignSystem.dangerText,
                      ),
                      SizedBox(width: 2 * scale),
                      Text(
                        '${delta!.abs().toStringAsFixed(1)}%',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12 * scale,
                          fontWeight: FontWeight.bold,
                          color: isPositive
                              ? PrimeCareDesignSystem.successText
                              : PrimeCareDesignSystem.dangerText,
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
                    style: TextStyle(
                      fontSize: 12 * scale,
                      color: PrimeCareDesignSystem.textMuted,
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
