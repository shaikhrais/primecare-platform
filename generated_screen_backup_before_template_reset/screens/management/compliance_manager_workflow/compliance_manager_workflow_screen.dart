import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/compliance_manager_workflow_header_section.dart';
import 'sections/compliance_manager_workflow_task_filters_section.dart';
import 'sections/compliance_manager_workflow_task_list_section.dart';
import 'sections/compliance_manager_workflow_task_details_section.dart';
import 'sections/compliance_manager_workflow_action_bar_section.dart';

class ComplianceManagerWorkflowScreen extends StatelessWidget {
  const ComplianceManagerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'compliance_manager_workflow',
      title: 'ComplianceManagerWorkflowScreen',
      child: Column(
        children: const [
          const ComplianceManagerWorkflowHeaderSection(),
          const ComplianceManagerWorkflowTaskFiltersSection(),
          const ComplianceManagerWorkflowTaskListSection(),
          const ComplianceManagerWorkflowTaskDetailsSection(),
          const ComplianceManagerWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
