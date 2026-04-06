import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class AccountsPayableScreen extends ConsumerWidget {
  const AccountsPayableScreen({super.key});

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
              'Accounts Payable',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tracking outgoing vendor and supplier payments. Aging summary.',
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
                         Text('Total AP Outstanding', style: PrimeCareTheme.typography.label),
                         const SizedBox(height: 8),
                         Text('\$4.2M', style: PrimeCareTheme.typography.h1.copyWith(color: PrimeCareTheme.colors.coralRed)),
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
                         Text('Pending Approvals', style: PrimeCareTheme.typography.label),
                         const SizedBox(height: 8),
                         Text('\$850k', style: PrimeCareTheme.typography.h1.copyWith(color: PrimeCareTheme.colors.amberWarning)),
                       ],
                     ),
                   ),
                 ),
               ],
            ),
            const SizedBox(height: 32),
            Text('Aging Summary', style: PrimeCareTheme.typography.h2),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAgingBucket('0-30 Days', '\$3.1M', PrimeCareTheme.colors.navyIndigo),
                _buildAgingBucket('31-60 Days', '\$900k', PrimeCareTheme.colors.amberWarning),
                _buildAgingBucket('61-90 Days', '\$150k', PrimeCareTheme.colors.coralRed),
                _buildAgingBucket('90+ Days', '\$50k', PrimeCareTheme.colors.coralRed),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgingBucket(String title, String amt, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        border: Border.all(color: color.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
          const SizedBox(height: 8),
          Text(amt, style: PrimeCareTheme.typography.h2.copyWith(color: color)),
        ],
      ),
    );
  }
}
