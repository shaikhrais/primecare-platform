// Governance - Category: view | Purpose: UI Screen component rendering the Physician Dashboard Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart' hide PhysicianDashboardScreen;
import 'package:lucide_icons/lucide_icons.dart';

class PhysicianDashboardScreen extends StatefulWidget {
  const PhysicianDashboardScreen({super.key});

  @override
  State<PhysicianDashboardScreen> createState() => _PhysicianDashboardScreenState();
}

class _PhysicianDashboardScreenState extends State<PhysicianDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Physician Dashboard'), backgroundColor: const Color(0xFF0F766E), foregroundColor: Colors.white),
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
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(LucideIcons.users, size: 40, color: Color(0xFF0F766E)),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Today\'s Appointments', style: TextStyle(color: Colors.grey)),
                              Text('14 Patients', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(LucideIcons.microscope, size: 40, color: Colors.blue),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Pending Lab Results', style: TextStyle(color: Colors.grey)),
                              Text('6 Results', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(LucideIcons.clipboardList, size: 40, color: Colors.orange),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Charts to Sign', style: TextStyle(color: Colors.grey)),
                              Text('9 Charts', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Upcoming Schedule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          _ScheduleRow(time: '09:00 AM', patient: 'John Doe', reason: 'Annual Physical', status: 'Waiting'),
                          _ScheduleRow(time: '09:30 AM', patient: 'Mary Smith', reason: 'Hypertension Follow-up', status: 'Not Arrived'),
                          _ScheduleRow(time: '10:00 AM', patient: 'Robert Chen', reason: 'Back Pain', status: 'Not Arrived'),
                          _ScheduleRow(time: '10:45 AM', patient: 'Susan White', reason: 'Diabetes Check', status: 'Not Arrived'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Urgent Tasks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          _TaskItem(title: 'Review MRI - D. Johnson', isCritical: true),
                          _TaskItem(title: 'Prescription Refill - E. Davis', isCritical: false),
                          _TaskItem(title: 'Sign discharge papers', isCritical: false),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
        ),
      ),
    );
  }
}

class _ScheduleRow extends StatelessWidget {
  final String time;
  final String patient;
  final String reason;
  final String status;
  const _ScheduleRow({required this.time, required this.patient, required this.reason, required this.status});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(time, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      title: Text(patient, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(reason),
      trailing: Chip(
        label: Text(status),
        backgroundColor: status == 'Waiting' ? Colors.orange[100] : Colors.grey[200],
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  final String title;
  final bool isCritical;
  const _TaskItem({required this.title, required this.isCritical});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(isCritical ? LucideIcons.alertCircle : LucideIcons.checkCircle, color: isCritical ? Colors.red : Colors.grey),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: TextStyle(fontWeight: isCritical ? FontWeight.bold : FontWeight.normal))),
        ],
      ),
    );
  }
}
