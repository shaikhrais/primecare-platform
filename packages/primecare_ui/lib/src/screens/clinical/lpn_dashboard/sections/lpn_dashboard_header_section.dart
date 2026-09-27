import 'package:flutter/material.dart';

class LpnDashboardHeaderSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const LpnDashboardHeaderSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'lpndashboard_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('LPN Clinical Workspace', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Welcome back, Clinical Care Coordinator.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
