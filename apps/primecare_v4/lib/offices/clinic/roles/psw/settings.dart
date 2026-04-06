import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage your application preferences and profile.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _buildSettingRow(LucideIcons.user, 'Profile Information', 'View and edit your personal details.'),
                  Divider(color: PrimeCareTheme.colors.surfaceContainerHighest, height: 32),
                  _buildSettingRow(LucideIcons.bell, 'Notifications', 'Manage alerts for schedule changes and updates.'),
                  Divider(color: PrimeCareTheme.colors.surfaceContainerHighest, height: 32),
                  _buildSettingRow(LucideIcons.map, 'Location Services', 'Manage GPS permissions for Check-In/Out.'),
                  Divider(color: PrimeCareTheme.colors.surfaceContainerHighest, height: 32),
                  _buildSettingRow(LucideIcons.shield, 'Security', 'Update password and authentication methods.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingRow(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: PrimeCareTheme.colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: PrimeCareTheme.colors.navyIndigo),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray),
              ),
            ],
          ),
        ),
        Icon(LucideIcons.chevronRight, color: PrimeCareTheme.colors.slateGray),
      ],
    );
  }
}
