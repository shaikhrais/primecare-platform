import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:primecare_core/primecare_core.dart';

class PrimeCareLineChart extends StatelessWidget {
  final AnalyticsChart chart;
  final Color lineColor;

  const PrimeCareLineChart({
    super.key,
    required this.chart,
    this.lineColor = const Color(0xFF3B82F6),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => const Color(0xFF1E293B),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) =>
                FlLine(color: const Color(0xFFE2E8F0), strokeWidth: 1),
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
                  return Text(
                    chart.dataPoints[index].label,
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 10,
                    ),
                  );
                },
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
          borderData: FlBorderData(show: false),
          lineBarsData: [
            // 1. Primary Historical Data Line
            LineChartBarData(
              spots: chart.dataPoints.asMap().entries.map((e) {
                return FlSpot(e.key.toDouble(), e.value.value);
              }).toList(),
              isCurved: true,
              color: lineColor,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: lineColor.withAlpha(25),
              ),
            ),
            // 2. Predictive Forecast Line (Dashed)
            if (chart.forecastDataPoints != null &&
                chart.forecastDataPoints!.isNotEmpty)
              LineChartBarData(
                spots: [
                  // Connect last historical point to first forecast point
                  FlSpot(
                    (chart.dataPoints.length - 1).toDouble(),
                    chart.dataPoints.last.value,
                  ),
                  ...chart.forecastDataPoints!.asMap().entries.map((e) {
                    return FlSpot(
                      (chart.dataPoints.length + e.key).toDouble(),
                      e.value.value,
                    );
                  }),
                ],
                isCurved: true,
                color: const Color(0xFF818CF8), // Aura Indigo
                barWidth: 3,
                dashArray: [5, 5],
                isStrokeCapRound: true,
                dotData: const FlDotData(show: true), // Show dots for forecast
                belowBarData: BarAreaData(show: false),
              ),
          ],
        ),
      ),
    );
  }
}
