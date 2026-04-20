import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:primecare_core/primecare_core.dart';

class PrimeCareBarChart extends ConsumerWidget {
  final AnalyticsChart chart;
  final Color barColor;

  const PrimeCareBarChart({
    super.key,
    required this.chart,
    this.barColor = const Color(0xFF1E40AF),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .read(executionGateProvider)
        .passGate(
          ExecutionGateCategory.auraEngine,
          'Rendering BarChart: ${chart.title} (${chart.dataPoints.length} bars)',
        );
    final auraActive = ref.watch(auraActiveVisualizationProvider);
    final auraAnomaly = ref.watch(auraActiveAnomalyProvider);

    return Container(
      height: 200,
      padding: const EdgeInsets.only(top: 16, right: 16),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: _getMaxValue() * 1.2,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => const Color(0xFF1E293B),
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${chart.dataPoints[groupIndex].label}\n',
                  const TextStyle(
                    color: PrimeCareColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: rod.toY.toStringAsFixed(0),
                      style: const TextStyle(
                        color: Color(0xFF93C5FD),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= chart.dataPoints.length)
                    return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      chart.dataPoints[index].label,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                reservedSize: 24,
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(chart.dataPoints.length, (i) {
            final spot = chart.dataPoints[i];

            // Aura Predictive Styling
            Color actualColor = spot.color != null
                ? Color(int.parse(spot.color!.replaceAll('#', '0xFF')))
                : barColor;

            double height = spot.value;
            bool isOutlier = height > (_getMaxValue() * 0.8);

            if (auraActive && isOutlier && auraAnomaly != null) {
              if (auraAnomaly.impact == InsightImpact.alert)
                actualColor = PrimeCareColors.rose;
              if (auraAnomaly.impact == InsightImpact.caution)
                actualColor = PrimeCareColors.amber;
              height +=
                  (height * 0.15); // Exaggerate the outlier for predictive view
            }

            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: height,
                  color: actualColor,
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  double _getMaxValue() {
    final hasData = chart.dataPoints.isNotEmpty;
    final maxValue = hasData
        ? chart.dataPoints.map((e) => e.value).reduce((a, b) => a > b ? a : b)
        : 10.0;
    return maxValue;
  }
}
