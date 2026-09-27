import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduler_workflow_header_section.dart';
import 'sections/scheduler_workflow_calendar_controls_section.dart';
import 'sections/scheduler_workflow_schedule_list_section.dart';
import 'sections/scheduler_workflow_appointment_details_section.dart';
import 'sections/scheduler_workflow_action_bar_section.dart';

class SchedulerWorkflowScreen extends StatelessWidget {
  const SchedulerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduler_workflow',
      title: 'SchedulerWorkflowScreen',
      child: Column(
        children: const [
          const SchedulerWorkflowHeaderSection(),
          const SchedulerWorkflowCalendarControlsSection(),
          const SchedulerWorkflowScheduleListSection(),
          const SchedulerWorkflowAppointmentDetailsSection(),
          const SchedulerWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
