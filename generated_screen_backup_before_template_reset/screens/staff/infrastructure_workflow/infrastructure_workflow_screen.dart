import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/infrastructure_workflow_header_section.dart';
import 'sections/infrastructure_workflow_task_filters_section.dart';
import 'sections/infrastructure_workflow_task_list_section.dart';
import 'sections/infrastructure_workflow_task_details_section.dart';
import 'sections/infrastructure_workflow_action_bar_section.dart';

class InfrastructureWorkflowScreen extends StatelessWidget {
  const InfrastructureWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'infrastructure_workflow',
      title: 'InfrastructureWorkflowScreen',
      child: Column(
        children: const [
          const InfrastructureWorkflowHeaderSection(),
          const InfrastructureWorkflowTaskFiltersSection(),
          const InfrastructureWorkflowTaskListSection(),
          const InfrastructureWorkflowTaskDetailsSection(),
          const InfrastructureWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
