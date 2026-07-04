import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduler_coordinator_reports_header_section.dart';
import 'sections/scheduler_coordinator_reports_calendar_controls_section.dart';
import 'sections/scheduler_coordinator_reports_schedule_list_section.dart';
import 'sections/scheduler_coordinator_reports_appointment_details_section.dart';
import 'sections/scheduler_coordinator_reports_action_bar_section.dart';

class SchedulerCoordinatorReportsScreen extends StatelessWidget {
  const SchedulerCoordinatorReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduler_coordinator_reports',
      title: 'Scheduler Coordinator Reports',
      child: Column(
        children: const [
          const SchedulerCoordinatorReportsHeaderSection(),
          const SchedulerCoordinatorReportsCalendarControlsSection(),
          const SchedulerCoordinatorReportsScheduleListSection(),
          const SchedulerCoordinatorReportsAppointmentDetailsSection(),
          const SchedulerCoordinatorReportsActionBarSection(),
        ],
      ),
    );
  }
}
