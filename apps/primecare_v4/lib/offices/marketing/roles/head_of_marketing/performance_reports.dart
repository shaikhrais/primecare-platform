import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class PerformanceReportsScreen extends ConsumerWidget {
  const PerformanceReportsScreen({super.key});

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
              'Performance Reports',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'High-level roll-ups of marketing ROI, CAC, and LTV across the brand.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildMetricCard('Customer Acquisition Cost (CAC)', '\$48.50', '-5% vs target', LucideIcons.trendingDown)),
                const SizedBox(width: 16),
                Expanded(child: _buildMetricCard('Lifetime Value (LTV)', '\$1,200', '+12% vs target', LucideIcons.trendingUp)),
                const SizedBox(width: 16),
                Expanded(child: _buildMetricCard('LTV:CAC Ratio', '24.7x', 'Healthy', LucideIcons.activity)),
              ],
            ),
             const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Generated Reports', style: PrimeCareTheme.typography.h2),
                  const SizedBox(height: 24),
                  _buildReportRow('Q1 2026 Marketing Performance Review', 'PDF', '12 MB'),
                  _buildReportRow('March 2026 Social Media Audit', 'PDF', '8 MB'),
                  _buildReportRow('Q4 2025 Annual Spend Retrospective', 'PDF', '18 MB'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String subtitle, IconData icon) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(title, style: PrimeCareTheme.typography.label, maxLines: 2)),
              Icon(icon, color: PrimeCareTheme.colors.emeraldTeal, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(value, style: PrimeCareTheme.typography.heroTitle),
          const SizedBox(height: 4),
          Text(subtitle, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.emeraldTeal)),
        ],
      ),
    );
  }

  Widget _buildReportRow(String title, String fileType, String size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(LucideIcons.fileText, color: PrimeCareTheme.colors.navyIndigo, size: 20),
              const SizedBox(width: 16),
              Text(title, style: PrimeCareTheme.typography.h3),
            ],
          ),
          Row(
            children: [
              Text('$fileType • $size', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
              const SizedBox(width: 16),
              ClinicalGlassButton(onPressed: (){}, icon: LucideIcons.download, label: 'Download'),
            ],
          )
        ],
      ),
    );
  }
}
