import 'package:flutter/material.dart';

class RmtAppointmentsAppointmentDetailsSection extends StatelessWidget {
  const RmtAppointmentsAppointmentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('rmt_appointments_appointment_details-section'),
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
