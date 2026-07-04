import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rmt_workflow_header_section.dart';
import 'sections/rmt_workflow_task_filters_section.dart';
import 'sections/rmt_workflow_task_list_section.dart';
import 'sections/rmt_workflow_task_details_section.dart';
import 'sections/rmt_workflow_action_bar_section.dart';

class RmtWorkflowScreen extends StatelessWidget {
  const RmtWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rmt_workflow',
      title: 'RmtWorkflowScreen',
      child: Column(
        children: const [
          const RmtWorkflowHeaderSection(),
          const RmtWorkflowTaskFiltersSection(),
          const RmtWorkflowTaskListSection(),
          const RmtWorkflowTaskDetailsSection(),
          const RmtWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
