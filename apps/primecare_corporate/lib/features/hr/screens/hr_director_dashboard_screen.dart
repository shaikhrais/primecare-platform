// Governance - Category: view | Purpose: UI Screen component rendering the Hr Director Dashboard Screen workspace interface.
import 'package:flutter/material.dart';

class HrDirectorDashboardScreen extends StatefulWidget {
  const HrDirectorDashboardScreen({Key? key}) : super(key: key);

  @override
  State<HrDirectorDashboardScreen> createState() => _HrDirectorDashboardScreenState();
}

class _HrDirectorDashboardScreenState extends State<HrDirectorDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Human Resources (CHRO)'), backgroundColor: Colors.purple.shade700),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            const Text('Enterprise Headcount & Hiring', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildMetric('Total Employees', '1,492', Colors.purple)),
                const SizedBox(width: 24),
                Expanded(child: _buildMetric('Open Requisitions', '84', Colors.orange)),
                const SizedBox(width: 24),
                Expanded(child: _buildMetric('Onboarding Pipeline', '32', Colors.green)),
              ],
            ),
            const SizedBox(height: 48),
            const Text('High Priority Requisitions', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: Icon(Icons.person_add, color: Colors.purple),
                title: const Text('Clinical Director (Toronto Central)'),
                subtitle: const Text('Open for 45 Days - Urgent'),
                trailing: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Accelerating requisition.')));
                  },
                  child: const Text('Boost Visibility'),
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

  Widget _buildMetric(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
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
