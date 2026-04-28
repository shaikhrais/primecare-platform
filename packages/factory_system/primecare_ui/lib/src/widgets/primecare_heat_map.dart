// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';

import 'package:primecare_ui/src/theme/design_system.dart';

class PrimeCareHeatMap extends StatelessWidget {
  final Map<DateTime, int> dataset;
  final String title;
  final double squareSize;

  const PrimeCareHeatMap({
    super.key,
    required this.dataset,
    this.title = 'DashboardActivity Heatmap',
    this.squareSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Container(
      padding: const EdgeInsets.all(PrimeCareSpacing.md),
      decoration: BoxDecoration(
        color: PrimeCareDesignSystem.surfaceElevated,
        borderRadius: PrimeCareRadii.boardLg,
        border: Border.all(color: PrimeCareDesignSystem.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty) ...[
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: PrimeCareSpacing.md),
          ],
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(52, (weekIndex) {
                return Column(
                  children: List.generate(7, (dayIndex) {
                    // Logic to color blocks based on dataset density
                    // We need a baseline date, let's assume it's one year ago starting today
                    final now = DateTime.now();
                    final startDate = now.subtract(const Duration(days: 365));

                    final daysOffset = (weekIndex * 7) + dayIndex;
                    final cellDate = startDate.add(Duration(days: daysOffset));

                    // strip time from cellDate for matching
                    final cellDateKey = DateTime(
                      cellDate.year,
                      cellDate.month,
                      cellDate.day,
                    );

                    // see if we have a value
                    int value = 0;
                    for (var entry in dataset.entries) {
                      final dt = entry.key;
                      if (dt.year == cellDateKey.year &&
                          dt.month == cellDateKey.month &&
                          dt.day == cellDateKey.day) {
                        value = entry.value;
                        break;
                      }
                    }

                    Color blockColor;
                    if (value == 0) {
                      blockColor = PrimeCareDesignSystem.borderSubtle
                          .withValues(alpha: 0.3);
                    } else if (value == 1) {
                      blockColor = primary.withValues(alpha: 0.3);
                    } else if (value == 2) {
                      blockColor = primary.withValues(alpha: 0.5);
                    } else if (value >= 3 && value <= 5) {
                      blockColor = primary.withValues(alpha: 0.7);
                    } else {
                      blockColor = primary;
                    }

                    return Container(
                      width: squareSize,
                      height: squareSize,
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: blockColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  }),
                );
              }),
            ),
          ),
          const SizedBox(height: PrimeCareSpacing.sm),
          Row(
            children: [
              Text(
                'Less',
                style: TextStyle(
                  fontSize: 10,
                  color: PrimeCareDesignSystem.textMuted,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 10,
                height: 10,
                color: PrimeCareDesignSystem.borderSubtle.withValues(
                  alpha: 0.3,
                ),
              ),
              const SizedBox(width: 2),
              Container(
                width: 10,
                height: 10,
                color: primary.withValues(alpha: 0.3),
              ),
              const SizedBox(width: 2),
              Container(
                width: 10,
                height: 10,
                color: primary.withValues(alpha: 0.5),
              ),
              const SizedBox(width: 2),
              Container(
                width: 10,
                height: 10,
                color: primary.withValues(alpha: 0.7),
              ),
              const SizedBox(width: 2),
              Container(width: 10, height: 10, color: primary),
              const SizedBox(width: 4),
              Text(
                'More',
                style: TextStyle(
                  fontSize: 10,
                  color: PrimeCareDesignSystem.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
