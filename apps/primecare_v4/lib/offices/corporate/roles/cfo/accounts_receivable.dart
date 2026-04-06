import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class AccountsReceivableScreen extends ConsumerWidget {
  const AccountsReceivableScreen({super.key});

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
              'Accounts Receivable',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tracking incoming payments from patients, insurance, and partners.',
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
                        Text('Total AR Outstanding', style: PrimeCareTheme.typography.label),
                        const SizedBox(height: 8),
                        Text('\$12.5M', style: PrimeCareTheme.typography.h1.copyWith(color: PrimeCareTheme.colors.emeraldTeal)),
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
                        Text('Days Sales Outstanding (DSO)', style: PrimeCareTheme.typography.label),
                        const SizedBox(height: 8),
                        Text('42 Days', style: PrimeCareTheme.typography.h1.copyWith(color: PrimeCareTheme.colors.amberWarning)),
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
                   Text('Payer Breakdown', style: PrimeCareTheme.typography.h2),
                   const SizedBox(height: 24),
                   _buildPayerRow('Insurance Providers', '\$8.1M'),
                   const SizedBox(height: 12),
                   _buildPayerRow('Government Grants', '\$2.4M'),
                   const SizedBox(height: 12),
                   _buildPayerRow('Patient Self-Pay', '\$2.0M'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayerRow(String title, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(LucideIcons.briefcase, size: 16, color: PrimeCareTheme.colors.navyIndigo),
            const SizedBox(width: 8),
            Text(title, style: PrimeCareTheme.typography.h3),
          ],
        ),
        Text(amount, style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.emeraldTeal)),
      ],
    );
  }
}
