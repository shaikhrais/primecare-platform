import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduler_coordinator_conflicts_header_section.dart';
import 'sections/scheduler_coordinator_conflicts_calendar_controls_section.dart';
import 'sections/scheduler_coordinator_conflicts_schedule_list_section.dart';
import 'sections/scheduler_coordinator_conflicts_appointment_details_section.dart';
import 'sections/scheduler_coordinator_conflicts_action_bar_section.dart';

class SchedulerCoordinatorConflictsScreen extends StatelessWidget {
  const SchedulerCoordinatorConflictsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduler_coordinator_conflicts',
      title: 'Scheduler Coordinator Conflicts',
      child: Column(
        children: const [
          const SchedulerCoordinatorConflictsHeaderSection(),
          const SchedulerCoordinatorConflictsCalendarControlsSection(),
          const SchedulerCoordinatorConflictsScheduleListSection(),
          const SchedulerCoordinatorConflictsAppointmentDetailsSection(),
          const SchedulerCoordinatorConflictsActionBarSection(),
        ],
      ),
    );
  }
}
