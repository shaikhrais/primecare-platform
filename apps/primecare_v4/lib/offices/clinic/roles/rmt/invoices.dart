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
                      'Billing & Invoices',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Manage RMT receipts, direct billing, and payment processing.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  icon: LucideIcons.receipt,
                  label: 'Generate Invoice',
                ),
              ],
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent Transactions', style: PrimeCareTheme.typography.h2),
                      Icon(LucideIcons.creditCard, color: PrimeCareTheme.colors.emeraldTeal),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildInvoiceRow('INV-2026-089', 'Emma Watson', '\$115.00', 'Paid - Insurance'),
                  const Divider(),
                  _buildInvoiceRow('INV-2026-088', 'Liam Chen', '\$90.00', 'Paid - Credit Card'),
                  const Divider(),
                  _buildInvoiceRow('INV-2026-087', 'David Lee', '\$145.00', 'Pending - eClaim'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceRow(String invoiceNo, String patient, String amount, String status) {
    final isPending = status.contains('Pending');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: PrimeCareTheme.colors.surfaceContainerLow,
            child: Icon(LucideIcons.fileDigit, color: PrimeCareTheme.colors.navyIndigo, size: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(patient, style: PrimeCareTheme.typography.h3),
                Text(invoiceNo, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
              Text(
                status,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: isPending ? PrimeCareTheme.colors.amberWarning : PrimeCareTheme.colors.emeraldTeal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          ClinicalGlassButton(onPressed: () {}, icon: LucideIcons.download, label: 'PDF'),
        ],
      ),
    );
  }
}
