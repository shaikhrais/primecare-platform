import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class RevenueScreen extends ConsumerWidget {
  const RevenueScreen({super.key});

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
              'Revenue Streams',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Detailed tracking of incoming funds by channel.',
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
                  Text('Distribution', style: PrimeCareTheme.typography.h2),
                  const SizedBox(height: 24),
                  _buildRevenueBar('Patient Out-of-Pocket', '\$62M', 0.8),
                  const SizedBox(height: 16),
                  _buildRevenueBar('Insurance Payers', '\$45M', 0.6),
                  const SizedBox(height: 16),
                  _buildRevenueBar('Government Grants', '\$20M', 0.3),
                  const SizedBox(height: 16),
                  _buildRevenueBar('Franchise Royalty Fees', '\$18.2M', 0.25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueBar(String label, String value, double pct) {
    return Row(
      children: [
        Expanded(flex: 3, child: Text(label, style: PrimeCareTheme.typography.h3)),
        Expanded(
          flex: 4,
          child: LinearProgressIndicator(
            value: pct,
            backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(PrimeCareTheme.colors.navyIndigo),
            minHeight: 12,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(value, style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.emeraldTeal))
          )
        ),
      ],
    );
  }
}
