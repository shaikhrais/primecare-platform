import 'package:flutter/material.dart';
import 'package:primecare_mobile/core/api_client.dart';
import '../../master/shared/widgets/page_template.dart';
import '../../master/shared/widgets/kpi_card.dart';

// Note: Navigates to physical /v1/psw/earnings via Ledger integrations

class PswEarningsScreen extends StatefulWidget {
  const PswEarningsScreen({super.key});

  @override
  State<PswEarningsScreen> createState() => _PswEarningsScreenState();
}

class _PswEarningsScreenState extends State<PswEarningsScreen> {
  bool _isLoading = true;
  List<dynamic> _payouts = [];
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchEarnings();
  }

  Future<void> _fetchEarnings() async {
    try {
      final res = await apiClient.get('/v1/psw/earnings');
      if (mounted) {
        setState(() {
          if (res is Map && res.containsKey('data')) {
            _payouts = res['data'] ?? [];
          } else if (res is List) {
            _payouts = res;
          } else {
            _payouts = [];
          }
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

        body: Center(child: Text('Error: $_error', style: const TextStyle(color: Colors.red))),
      );
    }

    double totalYtd = 0;
    double lastDeposit = 0;
    if (_payouts.isNotEmpty) {
      lastDeposit = (_payouts.first['amount'] ?? 0).toDouble();
      for (final p in _payouts) {
        totalYtd += (p['amount'] ?? 0).toDouble();
      }
    }

    return PageTemplate(
      title: 'Historical Earnings',
      subtitle: 'Verified Bank-Level Ledger Record',
      icon: Icons.account_balance,
      headerGradientColors: const [Colors.green, Colors.teal],
      kpiCards: [
        UnifiedKpiCard(
          title: 'Total (YTD)',
          value: '\$${totalYtd.toStringAsFixed(2)}',
          icon: Icons.trending_up,
          color: Colors.green,
        ),
        UnifiedKpiCard(
          title: 'Last Deposit',
          value: '\$${lastDeposit.toStringAsFixed(2)}',
          icon: Icons.receipt_long,
          color: Colors.blue,
        ),
      ],
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _payouts.isEmpty ? 1 : _payouts.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              if (_payouts.isEmpty) {
                return const ListTile(
                  title: Text('No earnings on record.'),
                  subtitle: Text('Complete your first shift to earn.'),
                );
              }

              final payout = _payouts[index];
              final amount = (payout['amount'] ?? 0).toDouble();
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.withValues(alpha: 0.1),
                  child: const Icon(Icons.download_done, color: Colors.green),
                ),
                title: Text('Direct Deposit - ${payout['createdAt'] != null ? payout['createdAt'].toString().split('T').first : 'Unknown Date'}'),
                subtitle: const Text('Approved by Operational Ledger'),
                trailing: Text(
                  '\$${amount.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
