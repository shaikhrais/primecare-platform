import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/governance_officer_workflow_header_section.dart';
import 'sections/governance_officer_workflow_task_filters_section.dart';
import 'sections/governance_officer_workflow_task_list_section.dart';
import 'sections/governance_officer_workflow_task_details_section.dart';
import 'sections/governance_officer_workflow_action_bar_section.dart';

class GovernanceOfficerWorkflowScreen extends StatelessWidget {
  const GovernanceOfficerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'governance_officer_workflow',
      title: 'GovernanceOfficerWorkflowScreen',
      child: Column(
        children: const [
          const GovernanceOfficerWorkflowHeaderSection(),
          const GovernanceOfficerWorkflowTaskFiltersSection(),
          const GovernanceOfficerWorkflowTaskListSection(),
          const GovernanceOfficerWorkflowTaskDetailsSection(),
          const GovernanceOfficerWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
