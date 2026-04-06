import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key});

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
              'Operating Expenses',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tracking operational expenditures, overhead, and CapEx.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildExpenseMetric('Total OpEx YTD', '\$102.4M', '+4% vs Budget', LucideIcons.trendingDown)),
                const SizedBox(width: 16),
                Expanded(child: _buildExpenseMetric('CapEx', '\$8.5M', '-12% vs Budget', LucideIcons.building)),
                const SizedBox(width: 16),
                Expanded(child: _buildExpenseMetric('Marketing Spend', '\$3.2M', 'On Track', LucideIcons.megaphone)),
              ],
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('Budget Utilization by Department', style: PrimeCareTheme.typography.h2),
                   const SizedBox(height: 24),
                   _buildBudgetRow('Engineering', 0.92, '\$14.2M / \$15M'),
                   const SizedBox(height: 12),
                   _buildBudgetRow('Clinical Staff', 0.98, '\$44.1M / \$45M', alert: true),
                   const SizedBox(height: 12),
                   _buildBudgetRow('Administration', 0.85, '\$11.9M / \$14M'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseMetric(String title, String value, String subtitle, IconData icon) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: PrimeCareTheme.typography.label),
              Icon(icon, color: PrimeCareTheme.colors.slateGray, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(value, style: PrimeCareTheme.typography.h1.copyWith(color: PrimeCareTheme.colors.coralRed)),
          const SizedBox(height: 4),
          Text(subtitle, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
        ],
      ),
    );
  }

  Widget _buildBudgetRow(String label, double utilization, String textVal, {bool alert = false}) {
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(label, style: PrimeCareTheme.typography.h3),
             Text(textVal, style: PrimeCareTheme.typography.body.copyWith(fontWeight: FontWeight.bold, color: alert ? PrimeCareTheme.colors.coralRed : PrimeCareTheme.colors.navyIndigo)),
           ],
         ),
         const SizedBox(height: 8),
         LinearProgressIndicator(
            value: utilization,
            backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(alert ? PrimeCareTheme.colors.coralRed : PrimeCareTheme.colors.emeraldTeal),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
       ],
     );
  }
}
