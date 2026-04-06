import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class FranchiseFinancialsScreen extends ConsumerWidget {
  const FranchiseFinancialsScreen({super.key});

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
              'Franchise Financials',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Consolidated view of royalty reports and P&L from franchise operators.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ClinicalGlassPanel(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('YTD Franchise Royalties', style: PrimeCareTheme.typography.label),
                        const SizedBox(height: 8),
                        Text('\$18.2M', style: PrimeCareTheme.typography.h1.copyWith(color: PrimeCareTheme.colors.emeraldTeal)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ClinicalGlassPanel(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Outstanding Royalty Arrears', style: PrimeCareTheme.typography.label),
                        const SizedBox(height: 8),
                        Text('\$1.1M', style: PrimeCareTheme.typography.h1.copyWith(color: PrimeCareTheme.colors.amberWarning)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(LucideIcons.store, color: PrimeCareTheme.colors.navyIndigo),
                      const SizedBox(width: 8),
                      Text('Top Performing Franchises', style: PrimeCareTheme.typography.h2),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildFranchiseRow('PRC-104: Calgary Center', '\$8.5M Rev', '\$425k Royalty'),
                  _buildFranchiseRow('PRC-092: Ottawa East', '\$6.2M Rev', '\$310k Royalty'),
                  _buildFranchiseRow('PRC-115: Halifax Core', '\$5.8M Rev', '\$290k Royalty'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFranchiseRow(String name, String rev, String royalty) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 2, child: Text(name, style: PrimeCareTheme.typography.h3)),
          Expanded(flex: 1, child: Text(rev, style: PrimeCareTheme.typography.body)),
          Expanded(flex: 1, child: Align(alignment: Alignment.centerRight, child: Text(royalty, style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.emeraldTeal)))),
        ],
      ),
    );
  }
}
