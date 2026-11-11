import 'package:flutter/material.dart';

/// Shared linear progress. The active Material progress theme owns its track;
/// callers retain their progress value, foreground animation and minimum height.
class PrimeLinearProgressIndicator extends StatelessWidget {
  final double? value;
  final Animation<Color?>? valueColor;
  final double? minHeight;

  const PrimeLinearProgressIndicator({super.key, this.value, this.valueColor, this.minHeight});

  @override
  Widget build(BuildContext context) => LinearProgressIndicator(
    value: value,
    valueColor: valueColor,
    minHeight: minHeight,
  );
}
