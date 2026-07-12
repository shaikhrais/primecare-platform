import 'package:flutter/material.dart';

class RmtDashboardHeaderSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const RmtDashboardHeaderSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'rmtdashboard_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('RMT Therapeutic Workspace', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Welcome back, Clinical Specialist.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
