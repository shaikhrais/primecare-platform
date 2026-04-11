import 'package:flutter/material.dart';

class PrimeCareBarChart extends StatelessWidget {
  final Map<String, double> data;
  final Color barColor;

  const PrimeCareBarChart({
    super.key,
    required this.data,
    required this.barColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: barColor.withAlpha(25),
      child: Center(
        child: Text('Chart Placeholder: ${data.length} data points'),
      ),
    );
  }
}
