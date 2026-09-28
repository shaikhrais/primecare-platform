import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_help_support_header_section.dart';
import 'sections/psw_help_support_content_summary_section.dart';
import 'sections/psw_help_support_primary_content_section.dart';
import 'sections/psw_help_support_action_bar_section.dart';

class PswHelpSupportScreen extends StatelessWidget {
  const PswHelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_help_support',
      title: 'Psw Help Support',
      child: Column(
        children: const [
          const PswHelpSupportHeaderSection(),
          const PswHelpSupportContentSummarySection(),
          const PswHelpSupportPrimaryContentSection(),
          const PswHelpSupportActionBarSection(),
        ],
      ),
    );
  }
}
