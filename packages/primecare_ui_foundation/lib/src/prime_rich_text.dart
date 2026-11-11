import 'package:flutter/material.dart';

/// Shared rich text retaining caller spans while inheriting theme and scaling.
class PrimeRichText extends StatelessWidget {
  final InlineSpan text;
  final TextAlign textAlign;

  const PrimeRichText({super.key, required this.text,
    this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) => RichText(
    text: TextSpan(style: DefaultTextStyle.of(context).style, children: [text]),
    textAlign: textAlign,
    textScaler: MediaQuery.maybeOf(context)?.textScaler ?? TextScaler.noScaling,
  );
}
