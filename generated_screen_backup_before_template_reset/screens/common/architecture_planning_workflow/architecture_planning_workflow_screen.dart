import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/architecture_planning_workflow_header_section.dart';
import 'sections/architecture_planning_workflow_task_filters_section.dart';
import 'sections/architecture_planning_workflow_task_list_section.dart';
import 'sections/architecture_planning_workflow_task_details_section.dart';
import 'sections/architecture_planning_workflow_action_bar_section.dart';

class ArchitecturePlanningWorkflowScreen extends StatelessWidget {
  const ArchitecturePlanningWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'architecture_planning_workflow',
      title: 'ArchitecturePlanningWorkflowScreen',
      child: Column(
        children: const [
          const ArchitecturePlanningWorkflowHeaderSection(),
          const ArchitecturePlanningWorkflowTaskFiltersSection(),
          const ArchitecturePlanningWorkflowTaskListSection(),
          const ArchitecturePlanningWorkflowTaskDetailsSection(),
          const ArchitecturePlanningWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
