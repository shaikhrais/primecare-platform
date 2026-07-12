import 'package:flutter/material.dart';

class TrainingDirectorDashboardRecentActivitySection extends StatelessWidget {
  final Map<String, dynamic> data;
  const TrainingDirectorDashboardRecentActivitySection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'training_director_dashboard_recent_activity_title',
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
