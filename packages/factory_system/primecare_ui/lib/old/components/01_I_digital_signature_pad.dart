// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:flutter/material.dart';

class DigitalSignaturePad extends StatelessWidget {
  const DigitalSignaturePad({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: PrimeCareColors.slate50,
            border: Border.all(
              color: PrimeCareColors.slate400,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              'Draw Signature Here',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(color: PrimeCareColors.slate400),
            ),
          ),
        ),
      ),
    );
  }
}
