import 'package:flutter/material.dart';

class SchedulerCoordinatorReportsAppointmentDetailsSection extends StatelessWidget {
  const SchedulerCoordinatorReportsAppointmentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('scheduler_coordinator_reports_appointment_details-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Appointment Details Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
