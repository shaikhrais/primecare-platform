import 'package:flutter/material.dart';

/// Shared icon that preserves inherited icon and disabled-control styling.
/// Callers may supply colors resolved from the active theme.
class PrimeIcon extends StatelessWidget {
  final IconData? icon;
  final double? size;
  final Color? color;
  final String? semanticLabel;
  final TextDirection? textDirection;

  const PrimeIcon(this.icon, {
    super.key,
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) => Icon(icon,
    size: size,
    color: color,
    semanticLabel: semanticLabel,
    textDirection: textDirection,
  );
}
