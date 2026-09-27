import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/legal_workflow_header_section.dart';
import 'sections/legal_workflow_task_filters_section.dart';
import 'sections/legal_workflow_task_list_section.dart';
import 'sections/legal_workflow_task_details_section.dart';
import 'sections/legal_workflow_action_bar_section.dart';

class LegalWorkflowScreen extends StatelessWidget {
  const LegalWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'legal_workflow',
      title: 'LegalWorkflowScreen',
      child: Column(
        children: const [
          const LegalWorkflowHeaderSection(),
          const LegalWorkflowTaskFiltersSection(),
          const LegalWorkflowTaskListSection(),
          const LegalWorkflowTaskDetailsSection(),
          const LegalWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
