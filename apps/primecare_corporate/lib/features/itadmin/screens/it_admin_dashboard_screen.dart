// Governance - Category: view | Purpose: UI Screen component rendering the It Admin Dashboard Screen workspace interface.
import 'package:flutter/material.dart';

class ItAdminDashboardScreen extends StatefulWidget {
  const ItAdminDashboardScreen({Key? key}) : super(key: key);

  @override
  State<ItAdminDashboardScreen> createState() => _ItAdminDashboardScreenState();
}

class _ItAdminDashboardScreenState extends State<ItAdminDashboardScreen> {
  final List<Map<String, dynamic>> _tickets = [
    {'id': 'TKT-994', 'user': 'Dr. Adams', 'issue': 'iPad EMR Login Failing'},
    {'id': 'TKT-995', 'user': 'Vancouver Reception', 'issue': 'Printer Offline'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('IT Admin Helpdesk'), backgroundColor: Colors.indigo.shade900),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Active Support Tickets', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _tickets.length,
                        itemBuilder: (context, index) {
                          final t = _tickets[index];
                          return Card(
                            child: ListTile(
                              leading: Icon(Icons.computer, color: Colors.indigo),
                              title: Text(t['issue'], style: TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text("\${t['id']} | Reported by: \${t['user']}"),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  setState(() => _tickets.removeAt(index));
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ticket closed.')));
                                },
                                child: const Text('Close Ticket'),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(width: 1, color: Colors.grey.shade300),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('NOC Status', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)),
                      child: const Row(
                        children: [
                          Icon(Icons.wifi, color: Colors.green),
                          SizedBox(width: 16),
                          Text('All VPN Tunnels Up', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        ),
      ),
      ),
    );
  }
}
