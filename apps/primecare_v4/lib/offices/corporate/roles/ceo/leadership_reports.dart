import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class LeadershipReportsScreen extends ConsumerWidget {
  const LeadershipReportsScreen({super.key});

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
              'Leadership Reports',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Direct reports from C-Suite and VP-level management.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildReportCard('Operations Update (COO)', 'System-wide efficiency up 4% this month.', 'Today 9:00 AM', LucideIcons.settings),
                const SizedBox(height: 16),
                _buildReportCard('Financial Audit (CFO)', 'Preliminary Q3 numbers looking strong.', 'Yesterday', LucideIcons.dollarSign),
                const SizedBox(height: 16),
                _buildReportCard('Compliance Brief (CCO)', 'Two minor infractions safely resolved.', 'Tuesday', LucideIcons.shieldAlert),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(String title, String snippet, String time, IconData icon) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
            child: Icon(icon, color: PrimeCareTheme.colors.navyIndigo),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: PrimeCareTheme.typography.h3),
                const SizedBox(height: 8),
                Text(snippet, style: PrimeCareTheme.typography.body),
              ],
            ),
          ),
          Text(time, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
        ],
      ),
    );
  }
}
