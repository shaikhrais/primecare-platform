import 'package:flutter/material.dart';

class ReceptionistAppointmentsCalendarControlsSection extends StatelessWidget {
  const ReceptionistAppointmentsCalendarControlsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('receptionist_appointments_calendar_controls-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Calendar Controls Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
