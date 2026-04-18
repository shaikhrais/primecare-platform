import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';

class PrimeCareProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final Color activeColor;
  final Color inactiveColor;

  const PrimeCareProgressBar({
    super.key,
    required this.progress,
    this.activeColor = PrimeCareColors.emerald,
    this.inactiveColor = const Color(0xFFEEEEEE),
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progress,
      backgroundColor: inactiveColor,
      valueColor: AlwaysStoppedAnimation(activeColor),
      minHeight: 12,
      borderRadius: BorderRadius.circular(6),
    );
  }
}
