import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduler_open_shifts_header_section.dart';
import 'sections/scheduler_open_shifts_calendar_controls_section.dart';
import 'sections/scheduler_open_shifts_schedule_list_section.dart';
import 'sections/scheduler_open_shifts_appointment_details_section.dart';
import 'sections/scheduler_open_shifts_action_bar_section.dart';

class SchedulerOpenShiftsScreen extends StatelessWidget {
  const SchedulerOpenShiftsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduler_open_shifts',
      title: 'SchedulerOpenShiftsScreen',
      child: Column(
        children: const [
          const SchedulerOpenShiftsHeaderSection(),
          const SchedulerOpenShiftsCalendarControlsSection(),
          const SchedulerOpenShiftsScheduleListSection(),
          const SchedulerOpenShiftsAppointmentDetailsSection(),
          const SchedulerOpenShiftsActionBarSection(),
        ],
      ),
    );
  }
}
