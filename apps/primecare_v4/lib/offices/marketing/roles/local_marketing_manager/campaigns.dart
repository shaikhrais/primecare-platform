import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class LocalCampaignsDataScreen extends ConsumerWidget {
  const LocalCampaignsDataScreen({super.key});

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
                      'Local Campaigns',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Manage campaigns running specifically in your local area.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalGlassButton(onPressed: (){}, icon: LucideIcons.plus, label: 'Create Local Ad'),
              ],
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Active Local Promos', style: PrimeCareTheme.typography.h2),
                  const SizedBox(height: 24),
                  _buildCampaignRow('Google Ads: Chiro Near Me', 'Running', 124, 18, '\$450'),
                  _buildCampaignRow('FB: Spring Massage Promo', 'Running', 412, 12, '\$120'),
                  _buildCampaignRow('Direct Mail: Community Drop', 'Completed', 0, 5, '\$800'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCampaignRow(String name, String status, int clicks, int leads, String spend) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 3, child: Text(name, style: PrimeCareTheme.typography.h3)),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: status == 'Running' ? PrimeCareTheme.colors.emeraldTeal.withOpacity(0.1) : PrimeCareTheme.colors.slateGray.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text(status, style: PrimeCareTheme.typography.label.copyWith(color: status == 'Running' ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
            )
          ),
          Expanded(
            flex: 2, 
            child: Center(
              child: Column(
                children: [
                  Text('$clicks', style: PrimeCareTheme.typography.h3),
                  Text('Clicks', style: PrimeCareTheme.typography.label),
                ],
              )
            )
          ),
          Expanded(
            flex: 2, 
            child: Center(
              child: Column(
                children: [
                  Text('$leads', style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
                  Text('Local Leads', style: PrimeCareTheme.typography.label),
                ],
              )
            )
          ),
          Expanded(flex: 2, child: Align(alignment: Alignment.centerRight, child: Text(spend, style: PrimeCareTheme.typography.h3))),
        ],
      )
    );
  }
}
