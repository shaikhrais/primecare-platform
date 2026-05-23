// Governance - Category: view | Purpose: UI Screen component rendering the Billing Admin Dashboard Screen workspace interface.
import 'package:flutter/material.dart';

class BillingAdminDashboardScreen extends StatefulWidget {
  const BillingAdminDashboardScreen({Key? key}) : super(key: key);

  @override
  State<BillingAdminDashboardScreen> createState() => _BillingAdminDashboardScreenState();
}

class _BillingAdminDashboardScreenState extends State<BillingAdminDashboardScreen> {
  final List<Map<String, dynamic>> _claims = [
    {'id': 'CLM-8843', 'patient': 'John Doe', 'insurer': 'BlueCross', 'amount': '\$450.00'},
    {'id': 'CLM-8844', 'patient': 'Alice Smith', 'insurer': 'Medicare', 'amount': '\$120.00'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Billing & Invoicing'), backgroundColor: Colors.green.shade800),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            const Text('Pending Insurance Claims', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            ..._claims.map((claim) => Card(
              child: ListTile(
                leading: const Icon(Icons.receipt, color: Colors.green, size: 40),
                title: Text("\${claim['id']} - \${claim['patient']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("Insurer: \${claim['insurer']} | Amount: \${claim['amount']}"),
                trailing: ElevatedButton(
                  onPressed: () {
                    setState(() => _claims.remove(claim));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Claim submitted to clearinghouse.')));
                  },
                  child: const Text('Submit Claim'),
                ),
              ),
            )).toList(),
            if (_claims.isEmpty)
              const Center(child: Text("All claims submitted!", style: TextStyle(fontSize: 18, color: Colors.green))),
          ],
        ),
        ),
      ),
      ),
    );
  }
}
