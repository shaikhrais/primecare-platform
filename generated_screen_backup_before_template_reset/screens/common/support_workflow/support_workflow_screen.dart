import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/support_workflow_header_section.dart';
import 'sections/support_workflow_task_filters_section.dart';
import 'sections/support_workflow_task_list_section.dart';
import 'sections/support_workflow_task_details_section.dart';
import 'sections/support_workflow_action_bar_section.dart';

class SupportWorkflowScreen extends StatelessWidget {
  const SupportWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'support_workflow',
      title: 'SupportWorkflowScreen',
      child: Column(
        children: const [
          const SupportWorkflowHeaderSection(),
          const SupportWorkflowTaskFiltersSection(),
          const SupportWorkflowTaskListSection(),
          const SupportWorkflowTaskDetailsSection(),
          const SupportWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
