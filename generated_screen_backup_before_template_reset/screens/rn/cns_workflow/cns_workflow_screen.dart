import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cns_workflow_header_section.dart';
import 'sections/cns_workflow_task_filters_section.dart';
import 'sections/cns_workflow_task_list_section.dart';
import 'sections/cns_workflow_task_details_section.dart';
import 'sections/cns_workflow_action_bar_section.dart';

class CnsWorkflowScreen extends StatelessWidget {
  const CnsWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cns_workflow',
      title: 'Clinical Nurse Specialist Compliance Workflow',
      child: Column(
        children: const [
          const CnsWorkflowHeaderSection(),
          const CnsWorkflowTaskFiltersSection(),
          const CnsWorkflowTaskListSection(),
          const CnsWorkflowTaskDetailsSection(),
          const CnsWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
