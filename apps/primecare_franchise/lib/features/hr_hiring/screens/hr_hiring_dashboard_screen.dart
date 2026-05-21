import 'package:flutter/material.dart';

class HrHiringDashboardScreen extends StatefulWidget {
  const HrHiringDashboardScreen({Key? key}) : super(key: key);

  @override
  State<HrHiringDashboardScreen> createState() => _HrHiringDashboardScreenState();
}

class _HrHiringDashboardScreenState extends State<HrHiringDashboardScreen> {
  final List<Map<String, dynamic>> _candidates = [
    {'name': 'Lisa Wong', 'role': 'Registered Nurse (RN)', 'stage': 'Interview'},
    {'name': 'James Miller', 'role': 'Personal Support Worker (PSW)', 'stage': 'Background Check'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Applicant Tracking System (ATS)'), backgroundColor: Colors.pink.shade800),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            const Text('Active Candidates pipeline', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            ..._candidates.map((c) => Card(
              child: ListTile(
                leading: const Icon(Icons.person_add, color: Colors.pink, size: 40),
                title: Text(c['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("Applying for: \${c['role']} | Current Stage: \${c['stage']}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, foregroundColor: Colors.white),
                      onPressed: () {
                        setState(() => c['stage'] = 'Hired');
                      },
                      child: const Text('Advance to Hired'),
                    ),
                  ],
                ),
              ),
            )).toList(),
          ],
        ),
        ),
      ),
      ),
    );
  }
}
