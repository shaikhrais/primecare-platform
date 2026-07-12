import 'package:flutter/material.dart';

class QualityAssuranceDashboardRecentActivitySection extends StatelessWidget {
  final Map<String, dynamic> data;
  const QualityAssuranceDashboardRecentActivitySection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'quality_assurance_dashboard_recent_activity_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Recent Activity Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Clinical Care Operations Status.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
