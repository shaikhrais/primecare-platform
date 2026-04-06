import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class RegionalCampaignsScreen extends ConsumerWidget {
  const RegionalCampaignsScreen({super.key});

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
              'Regional Campaigns',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Localized ad spend and campaign performance per franchise or territory.',
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
                    Text('Territory Comparison', style: PrimeCareTheme.typography.h2),
                    const SizedBox(height: 24),
                    _buildRegionRow('Ontario Central', '\$142k Spend', '5,400 Leads', '\$26.30 CAC'),
                    _buildRegionRow('BC Lower Mainland', '\$85k Spend', '3,100 Leads', '\$27.42 CAC'),
                    _buildRegionRow('Alberta South', '\$60k Spend', '1,800 Leads', '\$33.33 CAC'),
                    _buildRegionRow('Nova Scotia Metro', '\$25k Spend', '1,100 Leads', '\$22.72 CAC'),
                 ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegionRow(String name, String spend, String leads, String cac) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Icon(LucideIcons.mapPin, color: PrimeCareTheme.colors.navyIndigo, size: 16),
                const SizedBox(width: 8),
                Text(name, style: PrimeCareTheme.typography.h3),
              ],
            )
          ),
          Expanded(flex: 2, child: Text(spend, style: PrimeCareTheme.typography.body)),
          Expanded(flex: 2, child: Text(leads, style: PrimeCareTheme.typography.body)),
          Expanded(flex: 2, child: Align(alignment: Alignment.centerRight, child: Text(cac, style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.emeraldTeal)))),
        ],
      )
    );
  }
}
