import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RmtInvoicesScreen extends ConsumerWidget {
  const RmtInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Billing & Invoices',
      subtitle:
          'Manage client billing records, receipts, and insurance claims.',
      kpiCards: [
        KPICardData(
          title: 'Unpaid Invoices',
          value: '2',
          icon: LucideIcons.creditCard,
          trend: -1.0,
          trendLabel: 'vs last week',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Invoice Status', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterRow('Paid', 120, PrimeCareTheme.colors.emeraldTeal),
              _buildFilterRow('Unpaid', 2, PrimeCareTheme.colors.coralBlush),
              _buildFilterRow(
                'Direct Billing',
                45,
                PrimeCareTheme.colors.navyIndigo,
              ),
            ],
          ),
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Transactions',
                    style: PrimeCareTheme.typography.h2,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.receipt),
                    label: const Text('Generate Invoice'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.navyIndigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildInvoiceCard(
                'INV-1042',
                'John Smith',
                '\$115.00',
                'Paid',
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildInvoiceCard(
                'INV-1041',
                'Jane Doe',
                '\$90.00',
                'Unpaid',
                PrimeCareTheme.colors.coralBlush,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRow(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Text(
            count.toString(),
            style: PrimeCareTheme.typography.label.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceCard(
    String id,
    String clientName,
    String amount,
    String status,
    Color themeColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: themeColor, width: 4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(id, style: PrimeCareTheme.typography.h3),
                  const SizedBox(width: 8),
                  Text(
                    '•',
                    style: TextStyle(color: PrimeCareTheme.colors.slateGray),
                  ),
                  const SizedBox(width: 8),
                  Text(clientName, style: PrimeCareTheme.typography.body),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                amount,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: themeColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: PrimeCareTheme.typography.label.copyWith(
                color: themeColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
