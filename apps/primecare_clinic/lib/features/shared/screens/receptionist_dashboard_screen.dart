// Governance - Category: view | Purpose: UI Screen component rendering the Receptionist Dashboard Screen workspace interface.
import 'package:flutter/material.dart';

class ReceptionistDashboardScreen extends StatefulWidget {
  const ReceptionistDashboardScreen({Key? key}) : super(key: key);

  @override
  State<ReceptionistDashboardScreen> createState() => _ReceptionistDashboardScreenState();
}

class _ReceptionistDashboardScreenState extends State<ReceptionistDashboardScreen> {
  final List<Map<String, dynamic>> _queue = [
    {'name': 'Arthur Pendelton', 'time': '10:00 AM', 'status': 'Pending'},
    {'name': 'Martha Stewart', 'time': '10:30 AM', 'status': 'Pending'},
    {'name': 'Bruce Wayne', 'time': '11:00 AM', 'status': 'Pending'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Front Desk Reception'), backgroundColor: Colors.pink.shade700),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Incoming Patient Queue', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _queue.length,
                        itemBuilder: (context, index) {
                          final p = _queue[index];
                          final isCheckedIn = p['status'] == 'Checked In';
                          return Card(
                            color: isCheckedIn ? Colors.pink.shade50 : Colors.white,
                            child: ListTile(
                              leading: const CircleAvatar(backgroundColor: Colors.pink, child: Icon(Icons.person, color: Colors.white)),
                              title: Text(p['name'], style: TextStyle(fontWeight: FontWeight.bold, decoration: isCheckedIn ? TextDecoration.lineThrough : null)),
                              subtitle: Text("Appt: \${p['time']}"),
                              trailing: isCheckedIn
                                ? const Icon(Icons.check_circle, color: Colors.green)
                                : ElevatedButton(
                                    onPressed: () {
                                      setState(() => _queue[index]['status'] = 'Checked In');
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("\${p['name']} has been securely checked in to the EMR.")));
                                    },
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pink.shade700, foregroundColor: Colors.white),
                                    child: const Text('Check In'),
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(width: 1, color: Colors.grey.shade300),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Quick Actions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.calendar_month),
                      label: const Text('Book Appointment'),
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.phone),
                      label: const Text('Incoming Call Log'),
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
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
}