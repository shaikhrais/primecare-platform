import 'package:flutter/material.dart';
import '../theme/theme_tokens.dart';
import '../theme/design_system.dart';

class PrimeCareStatCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final isPositive = (delta ?? 0) >= 0;

    return Container(
      padding: PrimeCareSpacing.edgeAllLg,
      decoration: BoxDecoration(
        color: PrimeCareDesignSystem.surfaceElevated,
        borderRadius: PrimeCareRadii.boardLg,
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
                ),
              ),
              if (icon != null) Icon(icon, color: PrimeCareDesignSystem.textMuted, size: 20),
            ],
          ),
          const SizedBox(height: PrimeCareSpacing.md),
          Text(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          if (delta != null) ...[
            const SizedBox(height: PrimeCareSpacing.sm),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: PrimeCareSpacing.xs,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isPositive ? PrimeCareDesignSystem.successSurface : PrimeCareDesignSystem.dangerSurface,
                    borderRadius: PrimeCareRadii.boardSm,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isPositive
                            ? Icons.arrow_upward_rounded
                            : Icons.arrow_downward_rounded,
                        size: 12,
                        color: isPositive
                            ? const Color(0xFF10B981)
                            : const Color(0xFFE11D48),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${delta!.abs().toStringAsFixed(1)}%',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isPositive
                              ? const Color(0xFF10B981)
                              : const Color(0xFFE11D48),
                        ),
                      ),
                    ],
                  ),
                ),
                if (deltaSuffix != null) ...[
                  const SizedBox(width: PrimeCareSpacing.xs),
                  Text(
                    deltaSuffix!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 12, color: PrimeCareDesignSystem.textMuted),
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
