import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/quality_assurance_corrective_actions_header_section.dart';
import 'sections/quality_assurance_corrective_actions_task_filters_section.dart';
import 'sections/quality_assurance_corrective_actions_task_list_section.dart';
import 'sections/quality_assurance_corrective_actions_task_details_section.dart';
import 'sections/quality_assurance_corrective_actions_action_bar_section.dart';

class QualityAssuranceCorrectiveActionsScreen extends StatelessWidget {
  const QualityAssuranceCorrectiveActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'quality_assurance_corrective_actions',
      title: 'Quality Assurance Corrective Actions',
      child: Column(
        children: const [
          const QualityAssuranceCorrectiveActionsHeaderSection(),
          const QualityAssuranceCorrectiveActionsTaskFiltersSection(),
          const QualityAssuranceCorrectiveActionsTaskListSection(),
          const QualityAssuranceCorrectiveActionsTaskDetailsSection(),
          const QualityAssuranceCorrectiveActionsActionBarSection(),
        ],
      ),
    );
  }
}
