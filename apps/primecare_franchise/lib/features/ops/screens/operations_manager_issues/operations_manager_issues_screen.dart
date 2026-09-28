import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/operations_manager_issues_header_section.dart';
import 'sections/operations_manager_issues_content_summary_section.dart';
import 'sections/operations_manager_issues_primary_content_section.dart';
import 'sections/operations_manager_issues_action_bar_section.dart';

class OperationsManagerIssuesScreen extends StatelessWidget {
  const OperationsManagerIssuesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'operations_manager_issues',
      title: 'Operations Manager Issues',
      child: Column(
        children: const [
          const OperationsManagerIssuesHeaderSection(),
          const OperationsManagerIssuesContentSummarySection(),
          const OperationsManagerIssuesPrimaryContentSection(),
          const OperationsManagerIssuesActionBarSection(),
        ],
      ),
    );
  }
}
