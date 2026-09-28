import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/coo_issue_escalations_header_section.dart';
import 'sections/coo_issue_escalations_content_summary_section.dart';
import 'sections/coo_issue_escalations_primary_content_section.dart';
import 'sections/coo_issue_escalations_action_bar_section.dart';

class CooIssueEscalationsScreen extends StatelessWidget {
  const CooIssueEscalationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'coo_issue_escalations',
      title: 'Coo Issue Escalations',
      child: Column(
        children: const [
          const CooIssueEscalationsHeaderSection(),
          const CooIssueEscalationsContentSummarySection(),
          const CooIssueEscalationsPrimaryContentSection(),
          const CooIssueEscalationsActionBarSection(),
        ],
      ),
    );
  }
}
