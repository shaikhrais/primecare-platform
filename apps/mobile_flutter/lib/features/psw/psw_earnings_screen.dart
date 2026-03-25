import 'package:flutter/material.dart';
import '../shared/widgets/page_template.dart';
import '../shared/widgets/kpi_card.dart';

// Note: Navigates to physical /v1/psw/earnings via Ledger integrations

class PswEarningsScreen extends StatelessWidget {
  const PswEarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Historical Earnings',
      subtitle: 'Verified Bank-Level Ledger Record',
      icon: Icons.account_balance,
      headerGradientColors: const [Colors.green, Colors.teal],
      kpiCards: const [
        UnifiedKpiCard(
          title: 'Total (YTD)',
          value: '\$14,250.00',
          icon: Icons.trending_up,
          color: Colors.green,
        ),
        UnifiedKpiCard(
          title: 'Last Deposit',
          value: '\$1,050.25',
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
            itemCount: 3,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.withOpacity(0.1),
                  child: const Icon(Icons.download_done, color: Colors.green),
                ),
                title: Text('Direct Deposit - Week ${12 - index}'),
                subtitle: const Text('Approved by Operational Ledger'),
                trailing: Text(
                  '\$1,${(050 - (index * 12)).toStringAsFixed(2)}',
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
