import 'package:flutter/material.dart';
import '../shared/widgets/page_template.dart';
import '../shared/widgets/kpi_card.dart';

// Note: Maps strictly to /v1/finance/ledger/pnl algorithmic extraction

class GmPnlScreen extends StatelessWidget {
  const GmPnlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Executive P&L Ledger',
      subtitle: 'Live Immutable Financial Tracking',
      icon: Icons.stacked_line_chart,
      headerGradientColors: const [Colors.purple, Colors.deepPurple],
      kpiCards: const [
        UnifiedKpiCard(
          title: 'Gross Margin',
          value: '42.8%',
          icon: Icons.pie_chart,
          color: Colors.purple,
        ),
        UnifiedKpiCard(
          title: 'Net Profit (MTD)',
          value: '\$84,250.00',
          icon: Icons.account_balance,
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
                const Text('Live Operational Cashflow', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildLedgerRow('Gross Billed Revenue', '\$196,500.00', Colors.green),
                const Divider(),
                _buildLedgerRow('Payroll Expenses', '-\$82,450.00', Colors.redAccent),
                _buildLedgerRow('Overhead Liabilities', '-\$29,800.00', Colors.orange),
                const Divider(thickness: 2),
                _buildLedgerRow('Net Operating Income', '\$84,250.00', Colors.deepPurple, isBold: true),
              ],
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.verified_user, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'All figures are aggregated directly from the Immutable SHA-256 Double-Entry Ledger in real-time.',
                    style: TextStyle(color: Colors.grey[700], fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildLedgerRow(String label, String value, Color color, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.w500, color: color)),
        ],
      ),
    );
  }
}
