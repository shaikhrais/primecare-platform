import 'package:flutter/material.dart';

class PswShiftTrackerAppointmentDetailsSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const PswShiftTrackerAppointmentDetailsSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'psw_shift_tracker_appointment_details_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Appointment Details Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Clinical Care Operations Status.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
