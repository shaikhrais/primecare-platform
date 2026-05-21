import 'package:flutter/material.dart';

class PhysiotherapistDashboardScreen extends StatefulWidget {
  const PhysiotherapistDashboardScreen({Key? key}) : super(key: key);

  @override
  State<PhysiotherapistDashboardScreen> createState() => _PhysiotherapistDashboardScreenState();
}

class _PhysiotherapistDashboardScreenState extends State<PhysiotherapistDashboardScreen> {
  final List<String> _exercises = ['Gait Training', 'Range of Motion (ROM)', 'Resistance Band Exercises', 'Balance Therapy'];
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Physiotherapy Dashboard'), backgroundColor: Colors.deepPurple),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            const Text('Next Appointment: 10:00 AM', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            const Text('Patient: Arthur Pendelton (Post-Op Knee Replacement)', style: TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 32),
            const Text('Exercise Prescription', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ..._exercises.map((e) => Card(
              child: CheckboxListTile(
                title: Text(e),
                value: false,
                activeColor: Colors.deepPurple,
                onChanged: (val) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('\$e marked as completed.')));
                },
              ),
            )).toList(),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.accessibility_new),
              label: const Text('Log Mobility Assessment'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(50)),
            )
          ],
        ),
        ),
      ),
      ),
    );
  }
}