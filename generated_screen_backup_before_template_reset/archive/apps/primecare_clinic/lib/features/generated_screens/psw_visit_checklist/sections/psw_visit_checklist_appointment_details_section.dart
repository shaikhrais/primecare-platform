import 'package:flutter/material.dart';

class PswVisitChecklistAppointmentDetailsSection extends StatelessWidget {
  const PswVisitChecklistAppointmentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('psw_visit_checklist_appointment_details-section'),
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
