import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CampaignsScreen extends ConsumerWidget {
  const CampaignsScreen({super.key});

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
                Text(
                  'Global Campaigns',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
                ClinicalGlassButton(onPressed: (){}, icon: LucideIcons.plus, label: 'New Campaign'),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Top-level view of all active and planned marketing campaigns.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildMetric('Active Campaings', '12', LucideIcons.radio)),
                const SizedBox(width: 16),
                Expanded(child: _buildMetric('Total Spend Q1', '\$425k', LucideIcons.dollarSign)),
                const SizedBox(width: 16),
                Expanded(child: _buildMetric('Avg. CPA', '\$85.50', LucideIcons.target)),
              ],
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('Active Programs', style: PrimeCareTheme.typography.h2),
                   const SizedBox(height: 24),
                   _buildCampaignRow('Q1 Spring Wellness Push', 'Running', 0.85, '\$120k / \$150k Budget', '4,500 Leads'),
                   _buildCampaignRow('B2B Corporate Wellness', 'Running', 0.45, '\$45k / \$100k Budget', '320 MQLs'),
                   _buildCampaignRow('Local SEO Boost - BC', 'Optimization', 0.95, '\$19k / \$20k Budget', '12k Clicks'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(String title, String value, IconData icon) {
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

  Widget _buildCampaignRow(String name, String status, double budgetPct, String budgetText, String performance) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: PrimeCareTheme.typography.h3),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.emeraldTeal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(status, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.emeraldTeal, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(flex: 3, child: Text(budgetText, style: PrimeCareTheme.typography.body)),
              Expanded(
                flex: 4,
                child: LinearProgressIndicator(
                  value: budgetPct,
                  backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(PrimeCareTheme.colors.navyIndigo),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(LucideIcons.barChart2, size: 16, color: PrimeCareTheme.colors.slateGray),
                      const SizedBox(width: 8),
                      Text(performance, style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.emeraldTeal)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
