import 'package:flutter/material.dart';

class AppointmentOverviewCalendarControlsSection extends StatelessWidget {
  const AppointmentOverviewCalendarControlsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('appointment_overview_calendar_controls-section'),
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
