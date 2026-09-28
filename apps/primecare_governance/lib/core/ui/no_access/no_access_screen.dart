import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/no_access_header_section.dart';
import 'sections/no_access_content_summary_section.dart';
import 'sections/no_access_primary_content_section.dart';
import 'sections/no_access_action_bar_section.dart';

class NoAccessScreen extends StatelessWidget {
  const NoAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'no_access',
      title: 'No Access',
      child: Column(
        children: const [
          const NoAccessHeaderSection(),
          const NoAccessContentSummarySection(),
          const NoAccessPrimaryContentSection(),
          const NoAccessActionBarSection(),
        ],
      ),
    );
  }
}
