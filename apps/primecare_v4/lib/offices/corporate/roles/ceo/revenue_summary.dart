import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class RevenueSummaryScreen extends ConsumerWidget {
  const RevenueSummaryScreen({super.key});

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
              'Revenue Summary',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Top-level financial tracking and revenue stream analysis.',
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
                  Text('Revenue Streams', style: PrimeCareTheme.typography.h2),
                  const SizedBox(height: 16),
                  _buildRevenueRow('Franchise Fees', '\$42.5M', 0.8),
                  const SizedBox(height: 12),
                  _buildRevenueRow('Direct Patient Care', '\$85.2M', 1.0),
                  const SizedBox(height: 12),
                  _buildRevenueRow('B2B Contracts', '\$17.5M', 0.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueRow(String title, String value, double progress) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(title, style: PrimeCareTheme.typography.h3),
        ),
        Expanded(
          flex: 3,
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(PrimeCareTheme.colors.emeraldTeal),
            minHeight: 12,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(value, style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.emeraldTeal)),
          ),
        ),
      ],
    );
  }
}
