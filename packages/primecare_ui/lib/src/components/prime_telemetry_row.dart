import 'package:flutter/material.dart';
import '../theme/prime_theme.dart';
import 'prime_icon.dart';
import 'prime_text.dart';

/// Shared wrapping label/value row with caller-supplied active theme accent.
class PrimeTelemetryRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const PrimeTelemetryRow({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      children: [
        PrimeIcon(icon, color: color, size: 18),
        const SizedBox(width: 12),
        Expanded(child: PrimeText(
          label,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
            color: theme.colors.onSurfaceVariant,
          ),
        )),
        const SizedBox(width: 12),
        Flexible(child: PrimeText(
          value,
          style:  TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.bold,
            color: theme.colors.onSurface,
          ),
        )),
      ],
    );
  }
}
