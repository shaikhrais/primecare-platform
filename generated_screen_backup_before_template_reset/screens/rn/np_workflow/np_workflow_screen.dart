import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/np_workflow_header_section.dart';
import 'sections/np_workflow_task_filters_section.dart';
import 'sections/np_workflow_task_list_section.dart';
import 'sections/np_workflow_task_details_section.dart';
import 'sections/np_workflow_action_bar_section.dart';

class NpWorkflowScreen extends StatelessWidget {
  const NpWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'np_workflow',
      title: 'Nurse Practitioner (NP) Compliance Workflow',
      child: Column(
        children: const [
          const NpWorkflowHeaderSection(),
          const NpWorkflowTaskFiltersSection(),
          const NpWorkflowTaskListSection(),
          const NpWorkflowTaskDetailsSection(),
          const NpWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
