import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/coo_workflow_issues_header_section.dart';
import 'sections/coo_workflow_issues_task_filters_section.dart';
import 'sections/coo_workflow_issues_task_list_section.dart';
import 'sections/coo_workflow_issues_task_details_section.dart';
import 'sections/coo_workflow_issues_action_bar_section.dart';

class CooWorkflowIssuesScreen extends StatelessWidget {
  const CooWorkflowIssuesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'coo_workflow_issues',
      title: 'CooWorkflowIssuesScreen',
      child: Column(
        children: const [
          const CooWorkflowIssuesHeaderSection(),
          const CooWorkflowIssuesTaskFiltersSection(),
          const CooWorkflowIssuesTaskListSection(),
          const CooWorkflowIssuesTaskDetailsSection(),
          const CooWorkflowIssuesActionBarSection(),
        ],
      ),
    );
  }
}
