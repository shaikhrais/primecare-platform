import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/receptionist_workflow_header_section.dart';
import 'sections/receptionist_workflow_task_filters_section.dart';
import 'sections/receptionist_workflow_task_list_section.dart';
import 'sections/receptionist_workflow_task_details_section.dart';
import 'sections/receptionist_workflow_action_bar_section.dart';

class ReceptionistWorkflowScreen extends StatelessWidget {
  const ReceptionistWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'receptionist_workflow',
      title: 'ReceptionistWorkflowScreen',
      child: Column(
        children: const [
          const ReceptionistWorkflowHeaderSection(),
          const ReceptionistWorkflowTaskFiltersSection(),
          const ReceptionistWorkflowTaskListSection(),
          const ReceptionistWorkflowTaskDetailsSection(),
          const ReceptionistWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
