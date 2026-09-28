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
            color: Colors.white.withValues(alpha: 0.05),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1.5,
            ),
          ),
          child: const Icon(
            LucideIcons.shieldCheck,
            size: 56,
            color: Colors.greenAccent,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'PRIMECARE IDENTITY'.tr(),
          style: theme.typography.labelMedium.copyWith(
            color: Colors.white.withValues(alpha: 0.5),
            letterSpacing: 4.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
