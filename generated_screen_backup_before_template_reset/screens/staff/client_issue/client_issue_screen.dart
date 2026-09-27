import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/client_issue_header_section.dart';
import 'sections/client_issue_content_summary_section.dart';
import 'sections/client_issue_primary_content_section.dart';
import 'sections/client_issue_action_bar_section.dart';

class ClientIssueScreen extends StatelessWidget {
  const ClientIssueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'client_issue',
      title: 'ClientIssueScreen',
      child: Column(
        children: const [
          const ClientIssueHeaderSection(),
          const ClientIssueContentSummarySection(),
          const ClientIssuePrimaryContentSection(),
          const ClientIssueActionBarSection(),
        ],
      ),
    );
  }
}
