import 'package:flutter/material.dart';
import 'primecare_button.dart';

class PrimeButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isDanger;
  final bool isOutline;

  const PrimeButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isDanger = false,
    this.isOutline = false,
  });

  @override
  Widget build(BuildContext context) {
    return PrimeCareButton(
      label: label,
      onPressed: onPressed,
      type: isDanger
          ? PrimeCareButtonType.danger
          : (isOutline
                ? PrimeCareButtonType.secondary
                : PrimeCareButtonType.primary),
    );
  }
}
