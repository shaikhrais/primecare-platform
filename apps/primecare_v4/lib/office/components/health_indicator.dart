import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class HealthIndicator extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final double height;

  const HealthIndicator({
    Key? key,
    required this.progress,
    this.height = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.primaryFixed,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: constraints.maxWidth * progress,
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(height / 2),
              ),
            ),
          );
        },
      ),
    );
  }
}
