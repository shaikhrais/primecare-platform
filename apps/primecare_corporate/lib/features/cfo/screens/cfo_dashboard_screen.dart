import 'package:flutter/material.dart';

class CfoDashboardScreen extends StatefulWidget {
  const CfoDashboardScreen({Key? key}) : super(key: key);

  @override
  State<CfoDashboardScreen> createState() => _CfoDashboardScreenState();
}

class _CfoDashboardScreenState extends State<CfoDashboardScreen> {
  final List<Map<String, dynamic>> _approvals = [
    {'dept': 'IT Infrastructure', 'req': 'Q3 Server Upgrades', 'amount': '\$45,000'},
    {'dept': 'Marketing', 'req': 'National Ad Campaign', 'amount': '\$120,000'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Financial Ledger (CFO)'), backgroundColor: Colors.green.shade800),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            const Text('Capital Allocation & Approvals', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _buildMetric('Operating Cash', '\$4.2M', Colors.green)),
                const SizedBox(width: 24),
                Expanded(child: _buildMetric('Accounts Receivable', '\$1.8M', Colors.orange)),
                const SizedBox(width: 24),
                Expanded(child: _buildMetric('Burn Rate', '\$200K/mo', Colors.red)),
              ],
            ),
            const SizedBox(height: 48),
            const Text('Pending Budget Approvals', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ..._approvals.map((req) => Card(
              child: ListTile(
                leading: Icon(Icons.request_quote, color: Colors.green, size: 40),
                title: Text(req['req'], style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("Department: \${req['dept']}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(req['amount'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => _approvals.remove(req));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Approved \${req['amount']} for \${req['dept']}")));
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                      child: const Text('Authorize'),
                    )
                  ],
                ),
              ),
            )).toList()
          ],
        ),
        ),
      ),
      ),
    );
  }

  Widget _buildMetric(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(border: Border.all(color: color, width: 2), borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }
}
