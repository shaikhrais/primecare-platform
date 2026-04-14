import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

class PrimeCarePieChart extends ConsumerWidget {
  final AnalyticsChart chart;

  const PrimeCarePieChart({super.key, required this.chart});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auraActive = ref.watch(auraActiveVisualizationProvider);
    final auraAnomaly = ref.watch(auraActiveAnomalyProvider);

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          sections: chart.dataPoints.map((dp) {
            Color actualColor = dp.color != null
                ? Color(int.parse(dp.color!.replaceAll('#', '0xFF')))
                : Colors.blue;
                
            double radius = 50.0;
            
            // Aura Predictive Styling
            // Let's assume the highest value is the target of interest for anomalies
            final double maxValue = chart.dataPoints.map((e) => e.value).reduce((a, b) => a > b ? a : b);
            if (auraActive && dp.value == maxValue && auraAnomaly != null) {
               if (auraAnomaly.impact == InsightImpact.alert) actualColor = Colors.redAccent;
               if (auraAnomaly.impact == InsightImpact.caution) actualColor = Colors.orangeAccent;
               radius = 60.0; // Pop out the anomalous segment
            }

            return PieChartSectionData(
              color: actualColor,
              value: dp.value,
              title: dp.label,
              radius: radius,
              titleStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
