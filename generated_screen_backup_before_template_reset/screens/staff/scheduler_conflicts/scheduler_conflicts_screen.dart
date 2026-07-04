import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduler_conflicts_header_section.dart';
import 'sections/scheduler_conflicts_calendar_controls_section.dart';
import 'sections/scheduler_conflicts_schedule_list_section.dart';
import 'sections/scheduler_conflicts_appointment_details_section.dart';
import 'sections/scheduler_conflicts_action_bar_section.dart';

class SchedulerConflictsScreen extends StatelessWidget {
  const SchedulerConflictsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduler_conflicts',
      title: 'SchedulerConflictsScreen',
      child: Column(
        children: const [
          const SchedulerConflictsHeaderSection(),
          const SchedulerConflictsCalendarControlsSection(),
          const SchedulerConflictsScheduleListSection(),
          const SchedulerConflictsAppointmentDetailsSection(),
          const SchedulerConflictsActionBarSection(),
        ],
      ),
    );
  }
}
