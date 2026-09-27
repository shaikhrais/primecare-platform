import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/service_issue_header_section.dart';
import 'sections/service_issue_content_summary_section.dart';
import 'sections/service_issue_primary_content_section.dart';
import 'sections/service_issue_action_bar_section.dart';

class ServiceIssueScreen extends StatelessWidget {
  const ServiceIssueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'service_issue',
      title: 'ServiceIssueScreen',
      child: Column(
        children: const [
          const ServiceIssueHeaderSection(),
          const ServiceIssueContentSummarySection(),
          const ServiceIssuePrimaryContentSection(),
          const ServiceIssueActionBarSection(),
        ],
      ),
    );
  }
}
