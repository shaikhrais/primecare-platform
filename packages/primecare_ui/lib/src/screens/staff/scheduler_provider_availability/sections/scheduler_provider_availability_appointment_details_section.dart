import 'package:flutter/material.dart';

class SchedulerProviderAvailabilityAppointmentDetailsSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const SchedulerProviderAvailabilityAppointmentDetailsSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'scheduler_provider_availability_appointment_details_title',
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
