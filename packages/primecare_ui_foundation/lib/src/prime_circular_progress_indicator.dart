import 'package:flutter/material.dart';

/// Shared circular progress retaining the active SDK theme and caller overrides.
class PrimeCircularProgressIndicator extends StatelessWidget {
  final double? value;
  final Color? backgroundColor;
  final Color? color;
  final Animation<Color?>? valueColor;
  final double? strokeWidth;
  final StrokeCap? strokeCap;
  final String? semanticsLabel;
  final String? semanticsValue;

  const PrimeCircularProgressIndicator({super.key,this.value,this.backgroundColor,
    this.color,this.valueColor,this.strokeWidth,this.strokeCap,
    this.semanticsLabel,this.semanticsValue});

  @override
  Widget build(BuildContext context) => CircularProgressIndicator(
    value:value,backgroundColor:backgroundColor,color:color,valueColor:valueColor,
    strokeWidth:strokeWidth,strokeCap:strokeCap,
    semanticsLabel:semanticsLabel,semanticsValue:semanticsValue,
  );
}
