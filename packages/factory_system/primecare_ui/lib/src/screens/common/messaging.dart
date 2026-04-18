import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:primecare_ui/src/components/layouts/provider_layout.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderLayout(
      child: Center(
        child: Text(
          'Secure Messaging Center Pending Data Hydration',
          style: TextStyle(
            color: PrimeCareColors.white.withValues(alpha: 0.7),
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
