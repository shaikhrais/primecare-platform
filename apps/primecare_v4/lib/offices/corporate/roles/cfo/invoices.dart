import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class InvoicesScreen extends ConsumerWidget {
  const InvoicesScreen({super.key});

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
                        'Invoices',
                        style: PrimeCareTheme.typography.heroTitle.copyWith(
                          color: PrimeCareTheme.colors.navyIndigo,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Centralized ledger of all generated and received invoices.',
                        style: PrimeCareTheme.typography.body.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                      ),
                    ],
                  ),
                  ClinicalGlassButton(onPressed: (){}, icon: LucideIcons.plus, label: 'New Invoice')
               ],
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent Transactions', style: PrimeCareTheme.typography.h3),
                      ClinicalSearchTextField(hintText: 'Search INV-#...'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildInvoiceRow('INV-2026-042', 'MedTech Solutions', '\$14,500', 'Overdue'),
                  _buildInvoiceRow('INV-2026-043', 'Ontario Health', '\$120,000', 'Pending'),
                  _buildInvoiceRow('INV-2026-044', 'Toronto Gen Hospital', '\$45,000', 'Paid'),
                  _buildInvoiceRow('INV-2026-045', 'SurgiSupplies Inc.', '\$3,200', 'Pending'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceRow(String id, String client, String amount, String status) {
    Color statusColor;
    if (status == 'Paid') statusColor = PrimeCareTheme.colors.emeraldTeal;
    else if (status == 'Pending') statusColor = PrimeCareTheme.colors.amberWarning;
    else statusColor = PrimeCareTheme.colors.coralRed;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Icon(LucideIcons.fileText, color: PrimeCareTheme.colors.slateGray, size: 16),
                const SizedBox(width: 8),
                Text(id, style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
              ],
            ),
          ),
          Expanded(flex: 3, child: Text(client, style: PrimeCareTheme.typography.body)),
          Expanded(flex: 2, child: Text(amount, style: PrimeCareTheme.typography.h3)),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(status, style: PrimeCareTheme.typography.label.copyWith(color: statusColor, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
