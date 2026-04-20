import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:primecare_core/primecare_core.dart';

class PrimeCareLineChart extends ConsumerWidget {
  final AnalyticsChart chart;
  final Color lineColor;
  final bool isPredictive;

  const PrimeCareLineChart({
    super.key,
    required this.chart,
    this.lineColor = const Color(0xFF3B82F6),
    this.isPredictive = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .read(executionGateProvider)
        .passGate(
          ExecutionGateCategory.auraEngine,
          'Rendering LineChart: ${chart.title} (${chart.dataPoints.length} points)',
        );
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
            getDrawingHorizontalLine: (value) => FlLine(
              color: PrimeCareColors.white.withAlpha(20),
              strokeWidth: 1,
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
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      chart.dataPoints[index].label,
                      style: TextStyle(
                        color: PrimeCareColors.white.withAlpha(80),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
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
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                      radius: 4,
                      color: PrimeCareColors.white,
                      strokeWidth: 2,
                      strokeColor: lineColor,
                    ),
              ),
              shadow: Shadow(
                color: lineColor.withAlpha(150),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [lineColor.withAlpha(80), lineColor.withAlpha(5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            // 2. Predictive Forecast Line (Dashed)
            if (isPredictive &&
                chart.forecastDataPoints != null &&
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
                color: PrimeCareColors.purple,
                barWidth: 3,
                dashArray: [8, 8],
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) =>
                      FlDotCirclePainter(
                        radius: 3,
                        color: PrimeCareColors.purple,
                        strokeWidth: 2,
                        strokeColor: PrimeCareColors.white,
                      ),
                ),
                belowBarData: BarAreaData(show: false),
              ),
          ],
        ),
      ),
    );
  }
}
