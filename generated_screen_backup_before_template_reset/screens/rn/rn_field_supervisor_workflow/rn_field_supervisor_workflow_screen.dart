import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rn_field_supervisor_workflow_header_section.dart';
import 'sections/rn_field_supervisor_workflow_task_filters_section.dart';
import 'sections/rn_field_supervisor_workflow_task_list_section.dart';
import 'sections/rn_field_supervisor_workflow_task_details_section.dart';
import 'sections/rn_field_supervisor_workflow_action_bar_section.dart';

class RnFieldSupervisorWorkflowScreen extends StatelessWidget {
  const RnFieldSupervisorWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rn_field_supervisor_workflow',
      title: 'Registered Nurse (RN) Field Supervisor Compliance Workflow',
      child: Column(
        children: const [
          const RnFieldSupervisorWorkflowHeaderSection(),
          const RnFieldSupervisorWorkflowTaskFiltersSection(),
          const RnFieldSupervisorWorkflowTaskListSection(),
          const RnFieldSupervisorWorkflowTaskDetailsSection(),
          const RnFieldSupervisorWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
