import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart' hide PswDashboardScreen;
import 'package:lucide_icons/lucide_icons.dart';

class PswDashboardScreen extends StatefulWidget {
  const PswDashboardScreen({super.key});

  @override
  State<PswDashboardScreen> createState() => _PswDashboardScreenState();
}

class _PswDashboardScreenState extends State<PswDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PSW Daily Schedule'), backgroundColor: const Color(0xFF0F766E), foregroundColor: Colors.white),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0F766E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Current Status', style: TextStyle(color: Colors.white70)),
                      Text('Clocked In - On Route', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF0F766E)),
                    child: const Text('Clock Out'),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Today\'s Visits', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    _VisitCard(
                      time: '08:00 AM - 10:00 AM',
                      patient: 'Eleanor Rigby',
                      address: '123 Main St, Apt 4B',
                      tasks: const ['Assist with bathing', 'Prepare breakfast', 'Administer morning meds'],
                      status: 'Completed',
                    ),
                    _VisitCard(
                      time: '10:30 AM - 12:30 PM',
                      patient: 'Arthur Pendelton',
                      address: '456 Oak Ave',
                      tasks: const ['Light housekeeping', 'Mobility exercises', 'Prepare lunch'],
                      status: 'In Progress',
                    ),
                    _VisitCard(
                      time: '01:30 PM - 03:30 PM',
                      patient: 'Margaret Thatcher',
                      address: '789 Pine Rd',
                      tasks: const ['Grocery shopping', 'Companionship'],
                      status: 'Pending',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
        ),
      ),
    );
  }
}

class _VisitCard extends StatelessWidget {
  final String time;
  final String patient;
  final String address;
  final List<String> tasks;
  final String status;
  const _VisitCard({required this.time, required this.patient, required this.address, required this.tasks, required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    if (status == 'Completed') statusColor = Colors.green;
    else if (status == 'In Progress') statusColor = Colors.blue;
    else statusColor = Colors.orange;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(time, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                Chip(label: Text(status, style: const TextStyle(color: Colors.white)), backgroundColor: statusColor),
              ],
            ),
            const SizedBox(height: 8),
            Text(patient, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              children: [
                const Icon(LucideIcons.mapPin, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(address, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const Divider(height: 24),
            const Text('Required Tasks:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...tasks.map((t) => Row(
              children: [
                const Icon(LucideIcons.check, size: 16, color: Colors.green),
                const SizedBox(width: 8),
                Text(t),
              ],
            )).toList(),
            const SizedBox(height: 16),
            if (status == 'In Progress')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () {}, child: const Text('Complete Visit & Add Notes')),
              )
          ],
        ),
      ),
    );
  }
}
