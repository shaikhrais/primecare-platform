import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduler_booking_requests_header_section.dart';
import 'sections/scheduler_booking_requests_form_body_section.dart';
import 'sections/scheduler_booking_requests_validation_messages_section.dart';
import 'sections/scheduler_booking_requests_action_bar_section.dart';

class SchedulerBookingRequestsScreen extends StatelessWidget {
  const SchedulerBookingRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduler_booking_requests',
      title: 'SchedulerBookingRequestsScreen',
      child: Column(
        children: const [
          const SchedulerBookingRequestsHeaderSection(),
          const SchedulerBookingRequestsFormBodySection(),
          const SchedulerBookingRequestsValidationMessagesSection(),
          const SchedulerBookingRequestsActionBarSection(),
        ],
      ),
    );
  }
}
