// Governance - Category: view | Purpose: UI Screen component rendering the Rn Dashboard Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart' hide RnDashboardScreen;
import 'package:lucide_icons/lucide_icons.dart';

class RnDashboardScreen extends StatefulWidget {
  const RnDashboardScreen({super.key});

  @override
  State<RnDashboardScreen> createState() => _RnDashboardScreenState();
}

class _RnDashboardScreenState extends State<RnDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RN Dashboard'), backgroundColor: const Color(0xFF0F766E), foregroundColor: Colors.white),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Current Ward: Post-Op Care', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F766E))),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('My Patients (Triage)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 16),
                              _PatientTriageRow(room: 'Room 101', name: 'Alice Walker', status: 'Stable', vitals: 'BP 120/80, HR 72'),
                              _PatientTriageRow(room: 'Room 102', name: 'James Smith', status: 'Monitor', vitals: 'BP 145/90, HR 88'),
                              _PatientTriageRow(room: 'Room 105', name: 'Eva Brown', status: 'Stable', vitals: 'BP 118/76, HR 68'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Medication Schedule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 16),
                              _MedicationRow(time: '12:00 PM', patient: 'Alice Walker', med: 'Amoxicillin 500mg', isDue: true),
                              _MedicationRow(time: '14:00 PM', patient: 'James Smith', med: 'Lisinopril 10mg', isDue: false),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 2,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Shift Tasks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          _TaskCheckbox(task: 'Check vitals for Room 102', completed: false),
                          _TaskCheckbox(task: 'Update charting for Alice Walker', completed: true),
                          _TaskCheckbox(task: 'Change dressing - Room 105', completed: false),
                          _TaskCheckbox(task: 'Restock supply cart', completed: false),
                          const Divider(),
                          ElevatedButton(onPressed: () {}, child: const Text('View All Tasks')),
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

class _PatientTriageRow extends StatelessWidget {
  final String room;
  final String name;
  final String status;
  final String vitals;
  const _PatientTriageRow({required this.room, required this.name, required this.status, required this.vitals});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: status == 'Stable' ? Colors.green[100] : Colors.orange[100],
        child: Text(room.replaceAll('Room ', ''), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('Vitals: $vitals'),
      trailing: Chip(
        label: Text(status),
        backgroundColor: status == 'Stable' ? Colors.green[100] : Colors.orange[100],
      ),
    );
  }
}

class _MedicationRow extends StatelessWidget {
  final String time;
  final String patient;
  final String med;
  final bool isDue;
  const _MedicationRow({required this.time, required this.patient, required this.med, required this.isDue});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(LucideIcons.pill, color: isDue ? Colors.red : Colors.grey),
      title: Text(med, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('$patient at $time'),
      trailing: isDue ? ElevatedButton(onPressed: () {}, child: const Text('Administer')) : const Text('Scheduled', style: TextStyle(color: Colors.grey)),
    );
  }
}

class _TaskCheckbox extends StatelessWidget {
  final String task;
  final bool completed;
  const _TaskCheckbox({required this.task, required this.completed});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: completed,
      onChanged: (val) {},
      title: Text(task, style: TextStyle(decoration: completed ? TextDecoration.lineThrough : null)),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
