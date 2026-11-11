import 'package:flutter/material.dart';
import '../theme/prime_theme.dart';

/// Shared text control for generated and application content.
/// Follows the active typography while retaining caller styles and text scaling.
class PrimeText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const PrimeText(this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(data,
      style: style ?? context.theme.typography.bodyMedium,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
