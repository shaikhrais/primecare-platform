import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:primecare_core/primecare_core.dart';

class PrimeCareBarChart extends StatelessWidget {
  final AnalyticsChart chart;
  final Color barColor;

  const PrimeCareBarChart({
    super.key,
    required this.chart,
    this.barColor = const Color(0xFF1E40AF),
  });

  @override
  Widget build(BuildContext context) {
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
                    color: Colors.white,
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
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: spot.value,
                  color: spot.color != null
                      ? Color(int.parse(spot.color!.replaceAll('#', '0xFF')))
                      : barColor,
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
