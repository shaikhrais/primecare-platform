import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/lpn_workflow_header_section.dart';
import 'sections/lpn_workflow_task_filters_section.dart';
import 'sections/lpn_workflow_task_list_section.dart';
import 'sections/lpn_workflow_task_details_section.dart';
import 'sections/lpn_workflow_action_bar_section.dart';

class LpnWorkflowScreen extends StatelessWidget {
  const LpnWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'lpn_workflow',
      title: 'Licensed Practical Nurse (LPN) Compliance Workflow',
      child: Column(
        children: const [
          const LpnWorkflowHeaderSection(),
          const LpnWorkflowTaskFiltersSection(),
          const LpnWorkflowTaskListSection(),
          const LpnWorkflowTaskDetailsSection(),
          const LpnWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
