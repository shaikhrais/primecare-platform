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
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: const Icon(
            LucideIcons.shieldCheck,
            color: Colors.greenAccent,
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
                color: Colors.white.withValues(alpha: 0.5),
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Application Hub',
              style: theme.typography.h2.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
