import 'package:flutter/material.dart';

class PrimeCareBarChart extends StatelessWidget {
  final Map<String, double> data;
  final double height;
  final Color barColor;

  const PrimeCareBarChart({
    super.key,
    required this.data,
    this.height = 160.0,
    this.barColor = Colors.indigo,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox();

    final double maxVal = data.values.reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: data.entries.map((entry) {
          final barHeight = maxVal == 0 ? 0 : (entry.value / maxVal) * (height - 40);
          
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Value Label
              Text('\$${entry.value.toInt()}', overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.indigo)),
              const SizedBox(height: 6),
              // Animated Bar
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: barHeight.toDouble()),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOutQuart,
                builder: (context, value, child) {
                  return Container(
                    width: 32,
                    height: value,
                    decoration: BoxDecoration(
                      color: barColor.withOpacity(0.85),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: barColor.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              // X-Axis Label
              Text(entry.key, overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey)),
            ],
          );
        }).toList(),
      ),
    );
  }
}
