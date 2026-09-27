import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/operations_manager_workflow_header_section.dart';
import 'sections/operations_manager_workflow_task_filters_section.dart';
import 'sections/operations_manager_workflow_task_list_section.dart';
import 'sections/operations_manager_workflow_task_details_section.dart';
import 'sections/operations_manager_workflow_action_bar_section.dart';

class OperationsManagerWorkflowScreen extends StatelessWidget {
  const OperationsManagerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'operations_manager_workflow',
      title: 'OperationsManagerWorkflowScreen',
      child: Column(
        children: const [
          const OperationsManagerWorkflowHeaderSection(),
          const OperationsManagerWorkflowTaskFiltersSection(),
          const OperationsManagerWorkflowTaskListSection(),
          const OperationsManagerWorkflowTaskDetailsSection(),
          const OperationsManagerWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
