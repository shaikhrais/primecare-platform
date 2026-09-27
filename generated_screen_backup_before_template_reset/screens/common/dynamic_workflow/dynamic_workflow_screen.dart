import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/dynamic_workflow_header_section.dart';
import 'sections/dynamic_workflow_task_filters_section.dart';
import 'sections/dynamic_workflow_task_list_section.dart';
import 'sections/dynamic_workflow_task_details_section.dart';
import 'sections/dynamic_workflow_action_bar_section.dart';

class DynamicWorkflowScreen extends StatelessWidget {
  const DynamicWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'dynamic_workflow',
      title: 'DynamicScreenWorkflowScreen',
      child: Column(
        children: const [
          const DynamicWorkflowHeaderSection(),
          const DynamicWorkflowTaskFiltersSection(),
          const DynamicWorkflowTaskListSection(),
          const DynamicWorkflowTaskDetailsSection(),
          const DynamicWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
