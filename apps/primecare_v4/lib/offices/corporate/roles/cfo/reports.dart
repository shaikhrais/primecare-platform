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
              'Financial Reports',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Generated financial statements for internal review and board distribution.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildReportCard('Income Statement', 'Q1 2026', LucideIcons.fileText)),
                const SizedBox(width: 16),
                Expanded(child: _buildReportCard('Balance Sheet', 'As of Mar 31, 2026', LucideIcons.scale)),
                const SizedBox(width: 16),
                Expanded(child: _buildReportCard('Cash Flow', 'Q1 2026', LucideIcons.activity)),
              ],
            ),
            const SizedBox(height: 32),
            Text('Recent Archives', style: PrimeCareTheme.typography.h2),
            const SizedBox(height: 16),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _buildArchiveRow('2025 Annual Report (Audited)', 'Feb 15, 2026'),
                  _buildArchiveRow('Q4 2025 Financial Packet', 'Jan 10, 2026'),
                  _buildArchiveRow('Q3 2025 Financial Packet', 'Oct 12, 2025'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(String title, String subtitle, IconData icon) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: PrimeCareTheme.colors.navyIndigo),
          ),
          const SizedBox(height: 24),
          Text(title, style: PrimeCareTheme.typography.h3),
          const SizedBox(height: 8),
          Text(subtitle, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
          const SizedBox(height: 24),
          ClinicalGlassButton(onPressed: (){}, icon: LucideIcons.download, label: 'Export PDF', isPrimary: false),
        ],
      ),
    );
  }

  Widget _buildArchiveRow(String title, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Row(
             children: [
               Icon(LucideIcons.archive, size: 16, color: PrimeCareTheme.colors.slateGray),
               const SizedBox(width: 8),
               Text(title, style: PrimeCareTheme.typography.body),
             ],
           ),
           Text(date, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
         ],
      ),
    );
  }
}
