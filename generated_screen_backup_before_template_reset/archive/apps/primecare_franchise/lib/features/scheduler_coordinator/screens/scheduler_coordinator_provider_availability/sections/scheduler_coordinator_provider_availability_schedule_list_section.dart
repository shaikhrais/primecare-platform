import 'package:flutter/material.dart';

class SchedulerCoordinatorProviderAvailabilityScheduleListSection extends StatelessWidget {
  const SchedulerCoordinatorProviderAvailabilityScheduleListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('scheduler_coordinator_provider_availability_schedule_list-section'),
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
