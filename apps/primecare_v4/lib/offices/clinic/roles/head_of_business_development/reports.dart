import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

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
              'Business Intelligence & Reports',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Generate standard or custom reports across all business development metrics.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Scheduled Reports', style: PrimeCareTheme.typography.h2),
                  const SizedBox(height: 16),
                  _buildReportTile('Monthly Expansion Summary', 'Sent to Executive Board on 1st of month', LucideIcons.calendar),
                  _buildReportTile('Weekly Pipeline Health', 'Sent to BD Team every Monday', LucideIcons.barChart2),
                  _buildReportTile('Quarterly P&L Forecast', 'Financial modeling sent end of Qtr', LucideIcons.pieChart),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.plus,
              label: 'Create Custom Report',
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReportTile(String title, String subtitle, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.navyIndigo.withOpacity(0.05),
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
                Text(subtitle, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
              ],
            ),
          ),
          IconButton(
            icon: Icon(LucideIcons.download, color: PrimeCareTheme.colors.emeraldTeal),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
