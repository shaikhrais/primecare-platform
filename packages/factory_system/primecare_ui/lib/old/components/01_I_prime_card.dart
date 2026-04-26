// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:primecare_ui/src/components/01_I_primecare_card.dart';

class PrimeCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool isFlat;

  const PrimeCard({
    super.key,
    required this.child,
    this.padding,
    this.isFlat = false,
  });

  @override
  Widget build(BuildContext context) {
    return PrimeCareCard(padding: padding, isFlat: isFlat, child: child);
  }
}
