import 'package:flutter/material.dart';

class OperationsManagerDashboardScreen extends StatefulWidget {
  const OperationsManagerDashboardScreen({Key? key}) : super(key: key);

  @override
  State<OperationsManagerDashboardScreen> createState() => _OperationsManagerDashboardScreenState();
}

class _OperationsManagerDashboardScreenState extends State<OperationsManagerDashboardScreen> {
  final List<Map<String, dynamic>> _issues = [
    {'id': 'OPS-221', 'type': 'Equipment Failure', 'desc': 'Vital Sign Monitor #4 Offline', 'resolved': false},
    {'id': 'OPS-222', 'type': 'Supply Shortage', 'desc': 'Low stock of N95 Masks in Supply Room B', 'resolved': false},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Daily Operations'), backgroundColor: Colors.orange.shade800),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            const Text('Active Operational Issues', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            ..._issues.map((issue) => Card(
              child: ListTile(
                leading: const Icon(Icons.warning, color: Colors.orange, size: 40),
                title: Text(issue['desc'], style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("\${issue['id']} | Type: \${issue['type']}"),
                trailing: ElevatedButton(
                  onPressed: () {
                    setState(() => _issues.remove(issue));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Issue Marked as Resolved')));
                  },
                  child: const Text('Resolve'),
                ),
              ),
            )).toList(),
            if (_issues.isEmpty)
              const Center(child: Text("All operational issues resolved!", style: TextStyle(fontSize: 18, color: Colors.green))),
            const SizedBox(height: 48),
            const Text('Service Quality Checks', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('Infection Control Audit Passed'),
                subtitle: Text('Last audited 2 days ago. No corrective actions required.'),
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
