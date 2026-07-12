import 'package:flutter/material.dart';

class PediatricDashboardHeaderSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const PediatricDashboardHeaderSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'pediatricdashboard_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Pediatric Specialist Workspace', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Welcome back, Clinical Specialist.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
