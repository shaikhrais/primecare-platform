import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduler_coordinator_booking_requests_header_section.dart';
import 'sections/scheduler_coordinator_booking_requests_form_body_section.dart';
import 'sections/scheduler_coordinator_booking_requests_validation_messages_section.dart';
import 'sections/scheduler_coordinator_booking_requests_action_bar_section.dart';

class SchedulerCoordinatorBookingRequestsScreen extends StatelessWidget {
  const SchedulerCoordinatorBookingRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduler_coordinator_booking_requests',
      title: 'Scheduler Coordinator Booking Requests',
      child: Column(
        children: const [
          const SchedulerCoordinatorBookingRequestsHeaderSection(),
          const SchedulerCoordinatorBookingRequestsFormBodySection(),
          const SchedulerCoordinatorBookingRequestsValidationMessagesSection(),
          const SchedulerCoordinatorBookingRequestsActionBarSection(),
        ],
      ),
    );
  }
}
