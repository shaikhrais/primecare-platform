import 'package:flutter/material.dart';

class PhysicianDashboardHeaderSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const PhysicianDashboardHeaderSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'physiciandashboard_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Physician Clinical Workspace', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Welcome back, Chief Medical Specialist.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
