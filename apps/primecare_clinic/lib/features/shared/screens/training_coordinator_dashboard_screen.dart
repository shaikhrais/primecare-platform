// Governance - Category: view | Purpose: UI Screen component rendering the Training Coordinator Dashboard Screen workspace interface.
import 'package:flutter/material.dart';

class TrainingCoordinatorDashboardScreen extends StatefulWidget {
  const TrainingCoordinatorDashboardScreen({Key? key}) : super(key: key);

  @override
  State<TrainingCoordinatorDashboardScreen> createState() => _TrainingCoordinatorDashboardScreenState();
}

class _TrainingCoordinatorDashboardScreenState extends State<TrainingCoordinatorDashboardScreen> {
  final List<Map<String, dynamic>> _staff = [
    {'name': 'Nurse Davis', 'role': 'RN', 'cpr': true, 'whmis': true},
    {'name': 'Sarah Smith', 'role': 'PSW', 'cpr': true, 'whmis': false},
    {'name': 'Dr. Adams', 'role': 'MD', 'cpr': true, 'whmis': true},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Training & Certification Tracking'), backgroundColor: Colors.blueAccent),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            const Text('Staff Compliance Matrix', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Staff Member', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Role', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('CPR Certified', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('WHMIS 2026', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: _staff.map((s) {
                  return DataRow(
                    cells: [
                      DataCell(Text(s['name'])),
                      DataCell(Text(s['role'])),
                      DataCell(Icon(s['cpr'] ? Icons.check_circle : Icons.warning, color: s['cpr'] ? Colors.green : Colors.red)),
                      DataCell(
                        Row(
                          children: [
                            Icon(s['whmis'] ? Icons.check_circle : Icons.warning, color: s['whmis'] ? Colors.green : Colors.red),
                            if (!s['whmis']) ...[
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() => s['whmis'] = true);
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updated WHMIS certification for \${s['name']}")));
                                },
                                style: ElevatedButton.styleFrom(visualDensity: VisualDensity.compact),
                                child: const Text('Verify'),
                              )
                            ]
                          ],
                        )
                      ),
                    ],
                  );
                }).toList(),
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