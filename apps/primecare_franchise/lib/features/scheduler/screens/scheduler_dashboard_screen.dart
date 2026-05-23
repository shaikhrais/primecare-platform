// Governance - Category: view | Purpose: UI Screen component rendering the Scheduler Dashboard Screen workspace interface.
import 'package:flutter/material.dart';

class SchedulerDashboardScreen extends StatefulWidget {
  const SchedulerDashboardScreen({Key? key}) : super(key: key);

  @override
  State<SchedulerDashboardScreen> createState() => _SchedulerDashboardScreenState();
}

class _SchedulerDashboardScreenState extends State<SchedulerDashboardScreen> {
  final List<Map<String, dynamic>> _shifts = [
    {'provider': 'Dr. Sarah Jenkins', 'role': 'Physician', 'time': '08:00 AM - 04:00 PM', 'status': 'Confirmed'},
    {'provider': 'Nurse Mark T.', 'role': 'RN', 'time': '02:00 PM - 10:00 PM', 'status': 'Pending Approval'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Master Shift Calendar'), backgroundColor: Colors.cyan.shade800),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            const Text('Upcoming Shifts (Next 24 Hours)', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            ..._shifts.map((shift) => Card(
              child: ListTile(
                leading: const Icon(Icons.schedule, color: Colors.cyan, size: 40),
                title: Text("\${shift['provider']} (\${shift['role']})", style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("Time: \${shift['time']}"),
                trailing: shift['status'] == 'Pending Approval' 
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan, foregroundColor: Colors.white),
                      onPressed: () {
                        setState(() => shift['status'] = 'Confirmed');
                      },
                      child: const Text('Approve Shift'),
                    )
                  : const Text('Confirmed', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
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
