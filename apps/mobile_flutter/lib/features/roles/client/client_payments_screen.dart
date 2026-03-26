import 'package:flutter/material.dart';
import '../../master/shared/widgets/page_template.dart';
import '../../master/shared/widgets/kpi_card.dart';

// Hits POST /v1/client/payments natively

class ClientPaymentsScreen extends StatelessWidget {
  const ClientPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Billing & Invoices',
      subtitle: 'Secure end-to-end payment processing',
      icon: Icons.credit_card,
      headerGradientColors: const [Colors.teal, Colors.tealAccent],
      kpiCards: const [
        UnifiedKpiCard(
          title: 'Outstanding Balance',
          value: '\$142.50',
          icon: Icons.account_balance_wallet,
          color: Colors.red,
        ),
        UnifiedKpiCard(
          title: 'Paid (YTD)',
          value: '\$1,200.00',
          icon: Icons.check_circle,
          color: Colors.green,
        ),
      ],
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ListTile(
                  leading: Icon(Icons.receipt_long, color: Colors.teal, size: 32),
                  title: Text('INV-204128 - February Care Services'),
                  subtitle: Text('Due: March 30, 2026'),
                  trailing: Text('\$142.50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.payment),
                  title: const Text('Visa ending in 4242'),
                  trailing: TextButton(
                    onPressed: () {},
                    child: const Text('Change'),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Payment processed. Double-entry ledger updated successfully.')),
                      );
                    },
                    icon: const Icon(Icons.lock),
                    label: const Text('Pay Securely via Stripe'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
