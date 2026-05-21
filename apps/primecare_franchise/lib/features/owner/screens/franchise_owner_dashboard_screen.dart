import 'package:flutter/material.dart';

class FranchiseOwnerDashboardScreen extends StatefulWidget {
  const FranchiseOwnerDashboardScreen({Key? key}) : super(key: key);

  @override
  State<FranchiseOwnerDashboardScreen> createState() => _FranchiseOwnerDashboardScreenState();
}

class _FranchiseOwnerDashboardScreenState extends State<FranchiseOwnerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Franchise Operations Hub'), backgroundColor: Colors.deepPurple.shade900),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            const Text('Branch Performance Snapshot', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildMetric('Monthly Revenue', '\$142,500', Colors.green)),
                const SizedBox(width: 24),
                Expanded(child: _buildMetric('Active Patients', '482', Colors.blue)),
                const SizedBox(width: 24),
                Expanded(child: _buildMetric('Operating Margin', '18.4%', Colors.deepPurple)),
              ],
            ),
            const SizedBox(height: 48),
            const Text('Staff Rostering Status', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Card(
              child: ListTile(
                leading: Icon(Icons.people, color: Colors.blue),
                title: Text('12 Active Shifts Today'),
                subtitle: Text('2 RNs, 6 PSWs, 4 Administrative Staff on duty.'),
                trailing: Text('Fully Staffed', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              ),
            )
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
          Text(title, style: const TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }
}
