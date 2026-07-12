import 'package:flutter/material.dart';

class NpDashboardHeaderSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const NpDashboardHeaderSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'npdashboard_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('NP Clinical Workspace', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Welcome back, Clinical Director.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
