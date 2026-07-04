import 'package:flutter/material.dart';

class HswScheduleAppointmentDetailsSection extends StatelessWidget {
  const HswScheduleAppointmentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('hsw_schedule_appointment_details-section'),
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
