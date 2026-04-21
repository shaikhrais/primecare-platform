// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:primecare_ui/src/theme/01_I_design_system.dart';

class PrimeCareGaugeChart extends StatelessWidget {
  final double value; // 0 to 100
  final double height;
  final String title;
  final String subtitle;
  final Color? activeColor;

  const PrimeCareGaugeChart({
    super.key,
    required this.value,
    this.height = 180,
    this.title = '',
    this.subtitle = '',
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final primary = activeColor ?? Theme.of(context).primaryColor;
    final clampedValue = value.clamp(0.0, 100.0);

    return Container(
      height: height,
      padding: const EdgeInsets.all(PrimeCareSpacing.md),
      decoration: BoxDecoration(
        color: PrimeCareDesignSystem.surfaceElevated,
        borderRadius: PrimeCareRadii.boardLg,
        border: Border.all(color: PrimeCareDesignSystem.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (title.isNotEmpty) ...[
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: PrimeCareSpacing.xs),
          ],
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PieChart(
                  PieChartData(
                    startDegreeOffset: 180,
                    sectionsSpace: 0,
                    centerSpaceRadius: 50,
                    sections: [
                      PieChartSectionData(
                        color: primary,
                        value: clampedValue,
                        title: '',
                        radius: 20,
                      ),
                      PieChartSectionData(
                        color: PrimeCareDesignSystem.borderSubtle,
                        value: 100.0 - clampedValue,
                        title: '',
                        radius: 20,
                      ),
                      // Fake section to make it a half-circle
                      PieChartSectionData(
                        color: Colors.transparent,
                        value: 100,
                        title: '',
                        radius: 20,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${clampedValue.toInt()}%',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                      ),
                      if (subtitle.isNotEmpty)
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: PrimeCareDesignSystem.textMuted,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
