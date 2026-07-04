import 'package:flutter/material.dart';

class SchedulerCoordinatorAppointmentCalendarActionBarSection extends StatelessWidget {
  const SchedulerCoordinatorAppointmentCalendarActionBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('scheduler_coordinator_appointment_calendar_action_bar-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Action Bar Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
