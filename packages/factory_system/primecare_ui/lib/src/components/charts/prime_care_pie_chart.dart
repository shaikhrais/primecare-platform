import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:primecare_core/primecare_core.dart';

class PrimeCarePieChart extends StatelessWidget {
  final AnalyticsChart chart;

  const PrimeCarePieChart({super.key, required this.chart});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          sections: chart.data.map((data) {
            final color = data.color != null
                ? Color(int.parse(data.color!.replaceAll('#', '0xFF')))
                : Colors.blue;
            return PieChartSectionData(
              color: color,
              value: data.value,
              title: '${data.value.toInt()}${chart.unit ?? ''}',
              radius: 50,
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
