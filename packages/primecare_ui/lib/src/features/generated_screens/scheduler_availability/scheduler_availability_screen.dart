import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduler_availability_header_section.dart';
import 'sections/scheduler_availability_calendar_controls_section.dart';
import 'sections/scheduler_availability_schedule_list_section.dart';
import 'sections/scheduler_availability_appointment_details_section.dart';
import 'sections/scheduler_availability_action_bar_section.dart';

class SchedulerAvailabilityScreen extends StatelessWidget {
  const SchedulerAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduler_availability',
      title: 'Scheduler Availability',
      child: Column(
        children: const [
          const SchedulerAvailabilityHeaderSection(),
          const SchedulerAvailabilityCalendarControlsSection(),
          const SchedulerAvailabilityScheduleListSection(),
          const SchedulerAvailabilityAppointmentDetailsSection(),
          const SchedulerAvailabilityActionBarSection(),
        ],
      ),
    );
  }
}
