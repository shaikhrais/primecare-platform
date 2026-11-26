import 'package:flutter/material.dart';
import 'package:flutter_core/theme/theme_contrast.dart';
import '../theme/prime_theme.dart';

/// Compact trend label for a ten-percent success/warning tint on the page surface.
/// The active theme owns both the status role and a readable foreground.
class PrimeTrendLabel extends StatelessWidget {
  final String data;
  final bool isPositive;

  const PrimeTrendLabel(this.data, {super.key, required this.isPositive});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final status = isPositive ? colors.success : colors.warning;
    final background = Color.alphaBlend(status.withValues(alpha: 0.1), colors.surface);
    return Text(data, style: TextStyle(
      color: readableThemeForeground(background, status),
      fontSize: 11,
      fontWeight: FontWeight.bold,
    ));
  }
}
