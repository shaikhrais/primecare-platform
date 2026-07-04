import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rn_workflow_header_section.dart';
import 'sections/rn_workflow_task_filters_section.dart';
import 'sections/rn_workflow_task_list_section.dart';
import 'sections/rn_workflow_task_details_section.dart';
import 'sections/rn_workflow_action_bar_section.dart';

class RnWorkflowScreen extends StatelessWidget {
  const RnWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rn_workflow',
      title: 'RnWorkflowScreen',
      child: Column(
        children: const [
          const RnWorkflowHeaderSection(),
          const RnWorkflowTaskFiltersSection(),
          const RnWorkflowTaskListSection(),
          const RnWorkflowTaskDetailsSection(),
          const RnWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
