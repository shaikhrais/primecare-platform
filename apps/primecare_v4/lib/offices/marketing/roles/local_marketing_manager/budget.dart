import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class LocalBudgetScreen extends ConsumerWidget {
  const LocalBudgetScreen({super.key});

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
              'Local Budget & Co-Op Funds',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tracking franchise marketing budget and matching funds from corporate.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildBudgetCard('Total Budget (Q2)', '\$15,000', LucideIcons.dollarSign)),
                const SizedBox(width: 16),
                Expanded(child: _buildBudgetCard('Spend to Date', '\$8,450', LucideIcons.activity)),
                const SizedBox(width: 16),
                Expanded(child: _buildBudgetCard('Corporate Co-Op Match', '\$5,000', LucideIcons.heartHandshake)),
              ],
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('Budget Allocation', style: PrimeCareTheme.typography.h2),
                   const SizedBox(height: 24),
                   _buildAllocationRow('Digital Ads (Google/FB)', 0.65, '\$5,492 / \$8,450'),
                   _buildAllocationRow('Local Events & Sponsorships', 0.20, '\$1,690 / \$8,450'),
                   _buildAllocationRow('Print & Direct Mail', 0.15, '\$1,268 / \$8,450'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetCard(String title, String value, IconData icon) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: PrimeCareTheme.typography.label),
              Icon(icon, color: PrimeCareTheme.colors.emeraldTeal, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(value, style: PrimeCareTheme.typography.h1.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
        ],
      ),
    );
  }

  Widget _buildAllocationRow(String label, double utilization, String textVal) {
     return Padding(
       padding: const EdgeInsets.only(bottom: 16.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text(label, style: PrimeCareTheme.typography.h3),
               Text(textVal, style: PrimeCareTheme.typography.body.copyWith(fontWeight: FontWeight.bold, color: PrimeCareTheme.colors.navyIndigo)),
             ],
           ),
           const SizedBox(height: 8),
           LinearProgressIndicator(
              value: utilization,
              backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(PrimeCareTheme.colors.emeraldTeal),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
         ],
       ),
     );
  }
}
