import 'package:flutter/material.dart';

class PerformanceRadarChart extends StatelessWidget {
  const PerformanceRadarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.purple.shade100, width: 2),
      ),
      child: Center(
        child: Text(
          'RADAR\nCHART',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.purple.shade300,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
