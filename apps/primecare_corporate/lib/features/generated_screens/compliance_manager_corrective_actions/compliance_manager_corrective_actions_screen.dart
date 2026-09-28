import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/compliance_manager_corrective_actions_header_section.dart';
import 'sections/compliance_manager_corrective_actions_task_filters_section.dart';
import 'sections/compliance_manager_corrective_actions_task_list_section.dart';
import 'sections/compliance_manager_corrective_actions_task_details_section.dart';
import 'sections/compliance_manager_corrective_actions_action_bar_section.dart';

class ComplianceManagerCorrectiveActionsScreen extends StatelessWidget {
  const ComplianceManagerCorrectiveActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'compliance_manager_corrective_actions',
      title: 'Compliance Manager Corrective Actions',
      child: Column(
        children: const [
          const ComplianceManagerCorrectiveActionsHeaderSection(),
          const ComplianceManagerCorrectiveActionsTaskFiltersSection(),
          const ComplianceManagerCorrectiveActionsTaskListSection(),
          const ComplianceManagerCorrectiveActionsTaskDetailsSection(),
          const ComplianceManagerCorrectiveActionsActionBarSection(),
        ],
      ),
    );
  }
}
