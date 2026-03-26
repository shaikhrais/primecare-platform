import 'package:flutter/material.dart';

class ClientPaymentsScreen extends StatefulWidget {
  const ClientPaymentsScreen({Key? key}) : super(key: key);

  @override
  _ClientPaymentsScreenState createState() => _ClientPaymentsScreenState();
}

class _ClientPaymentsScreenState extends State<ClientPaymentsScreen> {
  final List<Map<String, dynamic>> _invoices = [
    {
      'id': 'INV-2023-001',
      'date': 'Oct 24, 2023',
      'amount': 150.00,
      'status': 'Unpaid',
      'description': 'Post-Op Care Visit (4 hrs)',
    },
    {
      'id': 'INV-2023-002',
      'date': 'Oct 18, 2023',
      'amount': 300.00,
      'status': 'Paid',
      'description': 'Weekly Checkup',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments & Billing'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _invoices.length,
        itemBuilder: (context, index) {
          final invoice = _invoices[index];
          final isUnpaid = invoice['status'] == 'Unpaid';
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        invoice['id'],
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Chip(
                        label: Text(
                          invoice['status'],
                          style: TextStyle(color: isUnpaid ? Colors.white : Colors.green.shade900),
                        ),
                        backgroundColor: isUnpaid ? Colors.orange : Colors.green.shade100,
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(invoice['description'], style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  Text('Date: ${invoice['date']}', style: theme.textTheme.bodySmall),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${invoice['amount'].toStringAsFixed(2)}',
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      if (isUnpaid)
                        ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing payment via Stripe...')),
                            );
                          },
                          icon: const Icon(Icons.payment),
                          label: const Text('Pay Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                          ),
                        )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
