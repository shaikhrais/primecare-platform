// Layer: 02_MODULAR_COMPONENTS
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

class PrimeCareDiskUsageCard extends ConsumerWidget {
  final int totalSectors;
  final int occupiedSectors;
  final int emptySectors;
  final int missingSectors;

  const PrimeCareDiskUsageCard({
    super.key,
    this.totalSectors = 337,
    this.occupiedSectors = 330,
    this.emptySectors = 0,
    this.missingSectors = 7,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('System File Table (SFT)', style: theme.typography.titleLarge),
                  Text(
                    'Codebase Maturity & Allotment Map',
                    style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: theme.spacing.sm, vertical: theme.spacing.xs),
                decoration: BoxDecoration(
                  color: theme.colors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(theme.spacing.xs),
                ),
                child: Text(
                  '${((occupiedSectors / totalSectors) * 100).toStringAsFixed(1)}% Healthy',
                  style: theme.typography.labelSmall.copyWith(
                    color: theme.colors.success,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: theme.spacing.lg),
          _buildSectorGrid(theme),
          SizedBox(height: theme.spacing.lg),
          _buildLegend(theme),
        ],
      ),
    );
  }

  Widget _buildSectorGrid(PrimeCareThemeData theme) {
    // We want a dense grid of sectors. 
    // For 337 sectors, a 20x17 grid approx.
    return Container(
      height: 120,
      width: double.infinity,
      padding: EdgeInsets.all(theme.spacing.xs),
      decoration: BoxDecoration(
        color: theme.colors.slate800,
        borderRadius: BorderRadius.circular(theme.spacing.sm),
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 30, // 30 per row for high density
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
        ),
        itemCount: totalSectors,
        itemBuilder: (context, index) {
          Color color;
          if (index < occupiedSectors) {
            color = theme.colors.success;
          } else if (index < occupiedSectors + emptySectors) {
            color = theme.colors.slate400; // Empty block
          } else {
            color = theme.colors.error; // Missing block
          }

          return Container(
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(1),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLegend(PrimeCareThemeData theme) {
    return Row(
      children: [
        _legendItem(theme, 'Occupied', theme.colors.success),
        SizedBox(width: theme.spacing.md),
        _legendItem(theme, 'Empty Block', theme.colors.slate400),
        SizedBox(width: theme.spacing.md),
        _legendItem(theme, 'Bad Block', theme.colors.error),
      ],
    );
  }

  Widget _legendItem(PrimeCareThemeData theme, String label, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: theme.spacing.xs),
        Text(label, style: theme.typography.labelSmall.copyWith(fontSize: 10)),
      ],
    );
  }
}
