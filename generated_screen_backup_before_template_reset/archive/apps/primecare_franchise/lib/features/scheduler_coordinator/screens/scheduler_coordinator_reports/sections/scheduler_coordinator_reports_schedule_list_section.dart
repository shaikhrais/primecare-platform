import 'package:flutter/material.dart';

class SchedulerCoordinatorReportsScheduleListSection extends StatelessWidget {
  const SchedulerCoordinatorReportsScheduleListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('scheduler_coordinator_reports_schedule_list-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Schedule List Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
