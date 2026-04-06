import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class TaxAndRemittanceScreen extends ConsumerWidget {
  const TaxAndRemittanceScreen({super.key});

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
              'Tax & Remittance Hub',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage corporate tax obligations, HST/GST tracking, and schedules.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Next Remittance Due', style: PrimeCareTheme.typography.label),
                        const SizedBox(height: 8),
                        Text('Apr 30, 2026', style: PrimeCareTheme.typography.h1.copyWith(color: PrimeCareTheme.colors.coralRed)),
                        const SizedBox(height: 4),
                        Text('Q1 Corporate Income Tax Installment', style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 80, color: PrimeCareTheme.colors.surfaceContainerHighest),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Est. Amount', style: PrimeCareTheme.typography.label),
                          const SizedBox(height: 8),
                          Text('\$425,000', style: PrimeCareTheme.typography.h1.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
                          const SizedBox(height: 4),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ClinicalGlassButton(onPressed: (){}, icon: LucideIcons.send, label: 'Authorize Payment', isPrimary: true),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text('HST / GST Tracking', style: PrimeCareTheme.typography.h2),
            const SizedBox(height: 16),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _buildTaxRow('Taxes Collected on Sales', '\$1,250,400'),
                  const SizedBox(height: 12),
                  _buildTaxRow('ITCs (Input Tax Credits)', '\$480,200', isDeduction: true),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(height: 1),
                  ),
                  _buildTaxRow('Net Remittance Required', '\$770,200', isBold: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaxRow(String label, String amount, {bool isDeduction = false, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: isBold ? PrimeCareTheme.typography.h3 : PrimeCareTheme.typography.body),
        Text(
          isDeduction ? '($amount)' : amount, 
          style: (isBold ? PrimeCareTheme.typography.h3 : PrimeCareTheme.typography.body)
            .copyWith(color: isDeduction ? PrimeCareTheme.colors.emeraldTeal : (isBold ? PrimeCareTheme.colors.coralRed : PrimeCareTheme.colors.navyIndigo))
        ),
      ],
    );
  }
}
