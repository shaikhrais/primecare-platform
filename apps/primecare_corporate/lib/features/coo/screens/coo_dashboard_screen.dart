// Governance - Category: view | Purpose: UI Screen component rendering the Coo Dashboard Screen workspace interface.
import 'package:flutter/material.dart';

class CooDashboardScreen extends StatefulWidget {
  const CooDashboardScreen({Key? key}) : super(key: key);

  @override
  State<CooDashboardScreen> createState() => _CooDashboardScreenState();
}

class _CooDashboardScreenState extends State<CooDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Global Operations (COO)'), backgroundColor: Colors.blue.shade900),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            const Text('Supply Chain & Clinic Health', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            Card(
              color: Colors.blue.shade50,
              child: const Padding(
                padding: EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    Icon(Icons.map, size: 100, color: Colors.blue),
                    SizedBox(width: 32),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Global Fleet & Delivery Network Active', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Text('All major supply chains operational. Medical supplies routing correctly.'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text('Critical Alerts', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Card(
              child: ListTile(
                leading: Icon(Icons.warning, color: Colors.red),
                title: Text('PPE Inventory Low in Region 4'),
                subtitle: Text('Franchises in Region 4 reporting < 10% PPE reserves.'),
                trailing: ElevatedButton(onPressed: null, child: Text('Deploy Emergency Stock')),
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
