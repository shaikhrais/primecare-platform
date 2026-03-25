import 'package:flutter/material.dart';
import '../theme/theme_tokens.dart';
import '../theme/theme_extension.dart';

class PrimeCareStatCard extends StatelessWidget {
  final String title;
  final String value;
  final double? delta;
  final String? deltaSuffix;
  final IconData? icon;

  const PrimeCareStatCard({
    super.key,
    required this.title,
    required this.value,
    this.delta,
    this.deltaSuffix,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.pTheme;
    final isPositive = (delta ?? 0) >= 0;

    return Container(
      padding: PrimeCareSpacing.edgeAllLg,
      decoration: BoxDecoration(
        color: t.surfaceElevated,
        borderRadius: PrimeCareRadii.boardLg,
        border: Border.all(color: t.borderSubtle, width: 1),
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
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: t.textMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (icon != null) Icon(icon, color: t.textMuted, size: 20),
            ],
          ),
          const SizedBox(height: PrimeCareSpacing.md),
          Text(value, style: Theme.of(context).textTheme.headlineMedium),
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
                    color: isPositive ? t.successSurface : t.dangerSurface,
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
                    style: TextStyle(fontSize: 12, color: t.textMuted),
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
