import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/workflow_issue_header_section.dart';
import 'sections/workflow_issue_task_filters_section.dart';
import 'sections/workflow_issue_task_list_section.dart';
import 'sections/workflow_issue_task_details_section.dart';
import 'sections/workflow_issue_action_bar_section.dart';

class WorkflowIssueScreen extends StatelessWidget {
  const WorkflowIssueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'workflow_issue',
      title: 'WorkflowIssueScreen',
      child: Column(
        children: const [
          const WorkflowIssueHeaderSection(),
          const WorkflowIssueTaskFiltersSection(),
          const WorkflowIssueTaskListSection(),
          const WorkflowIssueTaskDetailsSection(),
          const WorkflowIssueActionBarSection(),
        ],
      ),
    );
  }
}
