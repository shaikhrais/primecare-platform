import 'package:flutter/material.dart';

class SchedulerAnalyticsScheduleListSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const SchedulerAnalyticsScheduleListSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'scheduler_analytics_schedule_list_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Schedule List Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Clinical Care Operations Status.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
