// Governance - Category: view | Purpose: UI Screen component rendering the Cx Director Dashboard Screen workspace interface.
import 'package:flutter/material.dart';

class CxDirectorDashboardScreen extends StatefulWidget {
  const CxDirectorDashboardScreen({Key? key}) : super(key: key);

  @override
  State<CxDirectorDashboardScreen> createState() => _CxDirectorDashboardScreenState();
}

class _CxDirectorDashboardScreenState extends State<CxDirectorDashboardScreen> {
  final List<Map<String, dynamic>> _complaints = [
    {'patient': 'Emma Thompson', 'issue': 'Long wait time at Toronto Clinic', 'resolved': false},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Customer Experience'), backgroundColor: Colors.teal.shade700),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            const Text('Patient Satisfaction (NPS)', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(border: Border.all(color: Colors.teal, width: 2), borderRadius: BorderRadius.circular(16)),
              child: const Center(
                child: Column(
                  children: [
                    Text('Current NPS Score', style: TextStyle(fontSize: 18, color: Colors.grey)),
                    SizedBox(height: 8),
                    Text('+74', style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Colors.teal)),
                    Text('Top 10% of Healthcare Providers', style: TextStyle(color: Colors.green)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 48),
            const Text('Active Patient Complaints', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ..._complaints.map((c) => Card(
              child: ListTile(
                leading: Icon(Icons.feedback, color: Colors.orange),
                title: Text(c['issue']),
                subtitle: Text("Patient: \${c['patient']}"),
                trailing: ElevatedButton(
                  onPressed: () {
                    setState(() => _complaints.remove(c));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Complaint Resolved.')));
                  },
                  child: const Text('Resolve'),
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
}
