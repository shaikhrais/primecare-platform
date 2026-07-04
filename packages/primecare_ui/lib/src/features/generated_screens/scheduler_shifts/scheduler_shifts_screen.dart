import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduler_shifts_header_section.dart';
import 'sections/scheduler_shifts_calendar_controls_section.dart';
import 'sections/scheduler_shifts_schedule_list_section.dart';
import 'sections/scheduler_shifts_appointment_details_section.dart';
import 'sections/scheduler_shifts_action_bar_section.dart';

class SchedulerShiftsScreen extends StatelessWidget {
  const SchedulerShiftsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduler_shifts',
      title: 'Scheduler Shifts',
      child: Column(
        children: const [
          const SchedulerShiftsHeaderSection(),
          const SchedulerShiftsCalendarControlsSection(),
          const SchedulerShiftsScheduleListSection(),
          const SchedulerShiftsAppointmentDetailsSection(),
          const SchedulerShiftsActionBarSection(),
        ],
      ),
    );
  }
}
