import 'package:flutter/material.dart';

class SchedulerBookingRequestsValidationMessagesSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const SchedulerBookingRequestsValidationMessagesSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'scheduler_booking_requests_validation_messages_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Validation Messages Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Clinical Care Operations Status.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
