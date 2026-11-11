import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class SuccessProfileHeaderSection extends StatelessWidget {
  const SuccessProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: PrimeActionPalette.of(context, PrimeActionTone.primary).accent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: PrimeActionPalette.of(context, PrimeActionTone.primary).accent,
            ),
          ),
          child: Icon(
            LucideIcons.shieldCheck,
            color: PrimeActionPalette.of(context, PrimeActionTone.primary).accent,
            size: 28,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PRIMECARE HQ',
              style: theme.typography.labelMedium.copyWith(
                color: PrimeActionPalette.of(context, PrimeActionTone.primary).accent,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Application Hub',
              style: theme.typography.h2.copyWith(
                fontWeight: FontWeight.bold,
                color: PrimeActionPalette.of(context, PrimeActionTone.primary).accent,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
