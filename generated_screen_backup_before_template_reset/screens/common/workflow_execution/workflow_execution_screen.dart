import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/workflow_execution_header_section.dart';
import 'sections/workflow_execution_task_filters_section.dart';
import 'sections/workflow_execution_task_list_section.dart';
import 'sections/workflow_execution_task_details_section.dart';
import 'sections/workflow_execution_action_bar_section.dart';

class WorkflowExecutionScreen extends StatelessWidget {
  const WorkflowExecutionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'workflow_execution',
      title: 'WorkflowExecutionScreen',
      child: Column(
        children: const [
          const WorkflowExecutionHeaderSection(),
          const WorkflowExecutionTaskFiltersSection(),
          const WorkflowExecutionTaskListSection(),
          const WorkflowExecutionTaskDetailsSection(),
          const WorkflowExecutionActionBarSection(),
        ],
      ),
    );
  }
}
