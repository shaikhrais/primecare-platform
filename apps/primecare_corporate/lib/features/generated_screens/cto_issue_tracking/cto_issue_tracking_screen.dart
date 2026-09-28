import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cto_issue_tracking_header_section.dart';
import 'sections/cto_issue_tracking_content_summary_section.dart';
import 'sections/cto_issue_tracking_primary_content_section.dart';
import 'sections/cto_issue_tracking_action_bar_section.dart';

class CtoIssueTrackingScreen extends StatelessWidget {
  const CtoIssueTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cto_issue_tracking',
      title: 'Cto Issue Tracking',
      child: Column(
        children: const [
          const CtoIssueTrackingHeaderSection(),
          const CtoIssueTrackingContentSummarySection(),
          const CtoIssueTrackingPrimaryContentSection(),
          const CtoIssueTrackingActionBarSection(),
        ],
      ),
    );
  }
}
