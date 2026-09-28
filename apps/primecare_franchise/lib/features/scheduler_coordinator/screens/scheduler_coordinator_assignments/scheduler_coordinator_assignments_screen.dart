import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduler_coordinator_assignments_header_section.dart';
import 'sections/scheduler_coordinator_assignments_calendar_controls_section.dart';
import 'sections/scheduler_coordinator_assignments_schedule_list_section.dart';
import 'sections/scheduler_coordinator_assignments_appointment_details_section.dart';
import 'sections/scheduler_coordinator_assignments_action_bar_section.dart';

class SchedulerCoordinatorAssignmentsScreen extends StatelessWidget {
  const SchedulerCoordinatorAssignmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduler_coordinator_assignments',
      title: 'Scheduler Coordinator Assignments',
      child: Column(
        children: const [
          const SchedulerCoordinatorAssignmentsHeaderSection(),
          const SchedulerCoordinatorAssignmentsCalendarControlsSection(),
          const SchedulerCoordinatorAssignmentsScheduleListSection(),
          const SchedulerCoordinatorAssignmentsAppointmentDetailsSection(),
          const SchedulerCoordinatorAssignmentsActionBarSection(),
        ],
      ),
    );
  }
}
