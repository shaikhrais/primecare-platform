import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/failed_workflow_header_section.dart';
import 'sections/failed_workflow_task_filters_section.dart';
import 'sections/failed_workflow_task_list_section.dart';
import 'sections/failed_workflow_task_details_section.dart';
import 'sections/failed_workflow_action_bar_section.dart';

class FailedWorkflowScreen extends StatelessWidget {
  const FailedWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'failed_workflow',
      title: 'FailedWorkflowScreen',
      child: Column(
        children: const [
          const FailedWorkflowHeaderSection(),
          const FailedWorkflowTaskFiltersSection(),
          const FailedWorkflowTaskListSection(),
          const FailedWorkflowTaskDetailsSection(),
          const FailedWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
