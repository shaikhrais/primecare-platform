import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ConsentHeaderSection extends StatelessWidget {
  const ConsentHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: PrimeActionPalette.of(context, PrimeActionTone.success).surface,
            shape: BoxShape.circle,
            border: Border.all(
              color: context.theme.colors.outlineVariant,
              width: 1.5,
            ),
          ),
          child: Icon(
            LucideIcons.shieldCheck,
            size: 56,
            color: PrimeActionPalette.of(context, PrimeActionTone.success).onSurface,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'PRIMECARE IDENTITY'.tr(),
          style: theme.typography.labelMedium.copyWith(
            color: context.theme.colors.onSurfaceVariant,
            letterSpacing: 4.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
