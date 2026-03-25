import 'package:flutter/material.dart';
import 'package:primecare_mobile/core/api_client.dart';
import '../shared/widgets/page_template.dart';
import '../shared/widgets/kpi_card.dart';

// Note: Maps strictly to /v1/finance/ledger/pnl algorithmic extraction

class GmPnlScreen extends StatefulWidget {
  const GmPnlScreen({super.key});

  @override
  State<GmPnlScreen> createState() => _GmPnlScreenState();
}

class _GmPnlScreenState extends State<GmPnlScreen> {
  bool _isLoading = true;
  Map<String, dynamic>? _pnlData;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchPnl();
  }

  Future<void> _fetchPnl() async {
    try {
      final res = await apiClient.get('/v1/finance/ledger/pnl');
      if (mounted) {
        setState(() {
          _pnlData = res.data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_error.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Executive P&L Ledger')),
        body: Center(child: Text('Error: $_error', style: const TextStyle(color: Colors.red))),
      );
    }

    final grossRevenue = _pnlData?['grossRevenue'] ?? 0;
    final operatingExpenses = _pnlData?['operatingExpenses'] ?? 0;
    final netProfit = _pnlData?['netProfit'] ?? 0;
    final margin = _pnlData?['margin'] ?? '0.00%';

    return PageTemplate(
      title: 'Executive P&L Ledger',
      subtitle: 'Live Immutable Financial Tracking',
      icon: Icons.stacked_line_chart,
      headerGradientColors: const [Colors.purple, Colors.deepPurple],
      kpiCards: [
        UnifiedKpiCard(
          title: 'Gross Margin',
          value: margin,
          icon: Icons.pie_chart,
          color: Colors.purple,
        ),
        UnifiedKpiCard(
          title: 'Net Profit (YTD)',
          value: '\$${netProfit.toStringAsFixed(2)}',
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
                _buildLedgerRow('Gross Billed Revenue', '\$${grossRevenue.toStringAsFixed(2)}', Colors.green),
                const Divider(),
                _buildLedgerRow('Payroll Expenses / Liabilities', '-\$${operatingExpenses.toStringAsFixed(2)}', Colors.redAccent),
                const Divider(thickness: 2),
                _buildLedgerRow('Net Operating Income', '\$${netProfit.toStringAsFixed(2)}', Colors.deepPurple, isBold: true),
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
