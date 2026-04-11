import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/theme_tokens.dart';
import '../theme/design_system.dart';

class PrimeCarePieChartData {
  final String label;
  final double value;
  final Color color;

  const PrimeCarePieChartData({
    required this.label,
    required this.value,
    required this.color,
  });
}

class PrimeCarePieChart extends StatefulWidget {
  final List<PrimeCarePieChartData> data;
  final double height;
  final bool isDonut;
  final String title;

  const PrimeCarePieChart({
    super.key,
    required this.data,
    this.height = 200,
    this.isDonut = true,
    this.title = '',
  });

  @override
  State<PrimeCarePieChart> createState() => _PrimeCarePieChartState();
}

class _PrimeCarePieChartState extends State<PrimeCarePieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) return const SizedBox();
    return Container(
      height: widget.height,
      padding: const EdgeInsets.all(PrimeCareSpacing.md),
      decoration: BoxDecoration(
        color: PrimeCareDesignSystem.surfaceElevated,
        borderRadius: PrimeCareRadii.boardLg,
        border: Border.all(color: PrimeCareDesignSystem.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title.isNotEmpty) ...[
            Text(
              widget.title,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: PrimeCareSpacing.md),
          ],
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!
                                .touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: widget.isDonut ? 2 : 0,
                      centerSpaceRadius: widget.isDonut ? 30 : 0,
                      sections: List.generate(widget.data.length, (i) {
                        final isTouched = i == touchedIndex;
                        final double fontSize = isTouched ? 16 : 12;
                        final double radius = isTouched ? 50 : 40;
                        final item = widget.data[i];

                        return PieChartSectionData(
                          color: item.color,
                          value: item.value,
                          title:
                              '\$${item.value.toInt()}', // Assuming value is currency/number
                          radius: widget.isDonut
                              ? radius
                              : (isTouched ? 90 : 80),
                          titleStyle: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xffffffff),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                // Legend
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.data.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: item.color,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 11,
                              color:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.color ??
                                  Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
