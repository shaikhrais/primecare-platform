// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:primecare_ui/src/components/layouts/provider_layout.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderLayout(
      child: Center(
        child: Text(
          'Profile & Settings Interface Pending Data Hydration',
          style: TextStyle(
            color: PrimeCareColors.white.withValues(alpha: 0.7),
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
