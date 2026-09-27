import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ConsentConsentContentSection extends StatelessWidget {
  const ConsentConsentContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      children: [
        const SizedBox(height: 12),
        Text(
          'auth_consent_redirecting'.tr(),
          style: theme.typography.h2.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'Establishing secure session with the request application gateway...',
          style: theme.typography.bodyMedium.copyWith(
            color: Colors.white.withValues(alpha: 0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
