import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/volunteer_coordinator_workflow_header_section.dart';
import 'sections/volunteer_coordinator_workflow_task_filters_section.dart';
import 'sections/volunteer_coordinator_workflow_task_list_section.dart';
import 'sections/volunteer_coordinator_workflow_task_details_section.dart';
import 'sections/volunteer_coordinator_workflow_action_bar_section.dart';

class VolunteerCoordinatorWorkflowScreen extends StatelessWidget {
  const VolunteerCoordinatorWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'volunteer_coordinator_workflow',
      title: 'VolunteerCoordinatorWorkflowScreen',
      child: Column(
        children: const [
          const VolunteerCoordinatorWorkflowHeaderSection(),
          const VolunteerCoordinatorWorkflowTaskFiltersSection(),
          const VolunteerCoordinatorWorkflowTaskListSection(),
          const VolunteerCoordinatorWorkflowTaskDetailsSection(),
          const VolunteerCoordinatorWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
