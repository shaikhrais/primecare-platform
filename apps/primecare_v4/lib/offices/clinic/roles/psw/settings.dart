import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PswSettingsScreen extends ConsumerWidget {
  const PswSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'App Settings',
      subtitle: 'Manage your app preferences, notifications, and offline mode.',
      kpiCards: const [],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Preferences', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildNavRow('Notifications', LucideIcons.bell),
              _buildNavRow('Offline Sync', LucideIcons.wifiOff),
              _buildNavRow('Security', LucideIcons.lock),
              _buildNavRow('Help & Support', LucideIcons.helpCircle),
            ],
          ),
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Notifications', style: PrimeCareTheme.typography.h2),
              const SizedBox(height: 24),
              _buildSwitchSetting(
                'Schedule Changes',
                'Get notified when your shift or visits change.',
                true,
              ),
              _buildSwitchSetting(
                'Care Plan Updates',
                'Get notified when a client\'s care plan is updated by RN.',
                true,
              ),
              _buildSwitchSetting(
                'Broadcast Messages',
                'Receive urgent agency-wide alerts.',
                true,
              ),

              const Divider(height: 48),

              Text('Offline Sync', style: PrimeCareTheme.typography.h2),
              const SizedBox(height: 24),
              _buildSwitchSetting(
                'Auto-Download Care Plans',
                'Download assigned client forms when on Wi-Fi for offline access.',
                true,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.refreshCw),
                label: const Text('Force Manual Sync Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      PrimeCareTheme.colors.surfaceContainerHighest,
                  foregroundColor: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavRow(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: PrimeCareTheme.colors.slateGray),
          const SizedBox(width: 12),
          Text(label, style: PrimeCareTheme.typography.body),
        ],
      ),
    );
  }

  Widget _buildSwitchSetting(String title, String description, bool value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: PrimeCareTheme.typography.h3),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: (val) {},
            activeThumbColor: PrimeCareTheme.colors.emeraldTeal,
          ),
        ],
      ),
    );
  }
}
