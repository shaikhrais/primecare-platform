import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class FinancialOverviewScreen extends ConsumerWidget {
  const FinancialOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Financial Overview',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Holistic view of PrimeCare\'s financial health and EBITDA.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  icon: LucideIcons.download,
                  label: 'Export Ledger',
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildMetricCard('Total Revenue', '\$145.2M', '+18% YoY', LucideIcons.dollarSign)),
                const SizedBox(width: 16),
                Expanded(child: _buildMetricCard('Net Income', '\$34.1M', '+12% YoY', LucideIcons.trendingUp)),
                const SizedBox(width: 16),
                Expanded(child: _buildMetricCard('Operating Margin', '22.5%', '+2% MoM', LucideIcons.pieChart)),
                const SizedBox(width: 16),
                Expanded(child: _buildMetricCard('EBITDA', '\$42.8M', 'Target Met', LucideIcons.barChart2)),
              ],
            ),
            const SizedBox(height: 24),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cashflow Projections', style: PrimeCareTheme.typography.h2),
                  const SizedBox(height: 24),
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text('Chart rendering module required.', style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.slateGray)),
                    ),
                  )
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
              Text(title, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
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
}
