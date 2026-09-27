import 'package:flutter/material.dart';

class ChiropractorAppointmentsCalendarControlsSection extends StatelessWidget {
  const ChiropractorAppointmentsCalendarControlsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('chiropractor_appointments_calendar_controls-section'),
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
