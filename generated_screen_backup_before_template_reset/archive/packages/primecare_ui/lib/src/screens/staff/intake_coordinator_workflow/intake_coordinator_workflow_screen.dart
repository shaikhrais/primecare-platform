import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/intake_coordinator_workflow_header_section.dart';
import 'sections/intake_coordinator_workflow_task_filters_section.dart';
import 'sections/intake_coordinator_workflow_task_list_section.dart';
import 'sections/intake_coordinator_workflow_task_details_section.dart';
import 'sections/intake_coordinator_workflow_action_bar_section.dart';

class IntakeCoordinatorWorkflowScreen extends StatelessWidget {
  const IntakeCoordinatorWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'intake_coordinator_workflow',
      title: 'IntakeCoordinatorWorkflowScreen',
      child: Column(
        children: const [
          const IntakeCoordinatorWorkflowHeaderSection(),
          const IntakeCoordinatorWorkflowTaskFiltersSection(),
          const IntakeCoordinatorWorkflowTaskListSection(),
          const IntakeCoordinatorWorkflowTaskDetailsSection(),
          const IntakeCoordinatorWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
