// Governance - Category: view | Purpose: UI Screen component rendering the Intake Coordinator Dashboard Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart' hide IntakeCoordinatorDashboardScreen;
import 'package:lucide_icons/lucide_icons.dart';

class IntakeCoordinatorDashboardScreen extends StatefulWidget {
  const IntakeCoordinatorDashboardScreen({super.key});

  @override
  State<IntakeCoordinatorDashboardScreen> createState() => _IntakeCoordinatorDashboardScreenState();
}

class _IntakeCoordinatorDashboardScreenState extends State<IntakeCoordinatorDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Intake Coordinator Dashboard'), backgroundColor: const Color(0xFF0F766E), foregroundColor: Colors.white),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _MetricCard(title: 'Pending Referrals', value: '12', icon: LucideIcons.fileText, color: Colors.orange)),
                const SizedBox(width: 16),
                Expanded(child: _MetricCard(title: 'Insurance Verifications', value: '5', icon: LucideIcons.shieldCheck, color: Colors.blue)),
                const SizedBox(width: 16),
                Expanded(child: _MetricCard(title: 'Intakes Scheduled Today', value: '8', icon: LucideIcons.calendar, color: Colors.green)),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('New Patient Referrals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    DataTable(
                      columns: const [
                        DataColumn(label: Text('Patient Name')),
                        DataColumn(label: Text('Referred By')),
                        DataColumn(label: Text('Service Type')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Action')),
                      ],
                      rows: [
                        _referralRow('Michael Chang', 'Dr. Adams', 'Physiotherapy', 'Pending Review'),
                        _referralRow('Sarah Connor', 'City Hospital', 'Post-Op Care', 'Insurance Pending'),
                        _referralRow('David Miller', 'Dr. Adams', 'Home Care', 'Approved'),
                      ],
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

  DataRow _referralRow(String name, String referrer, String service, String status) {
    return DataRow(cells: [
      DataCell(Text(name, style: const TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text(referrer)),
      DataCell(Text(service)),
      DataCell(Chip(label: Text(status), backgroundColor: status == 'Approved' ? Colors.green[100] : Colors.orange[100])),
      DataCell(TextButton(onPressed: () {}, child: const Text('Process'))),
    ]);
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Icon(icon, color: color)),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.grey)),
                Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
