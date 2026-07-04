import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/email_marketing_automator_header_section.dart';
import 'sections/email_marketing_automator_content_summary_section.dart';
import 'sections/email_marketing_automator_primary_content_section.dart';
import 'sections/email_marketing_automator_action_bar_section.dart';

class EmailMarketingAutomatorScreen extends StatelessWidget {
  const EmailMarketingAutomatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'email_marketing_automator',
      title: 'Email Marketing Automator',
      child: Column(
        children: const [
          const EmailMarketingAutomatorHeaderSection(),
          const EmailMarketingAutomatorContentSummarySection(),
          const EmailMarketingAutomatorPrimaryContentSection(),
          const EmailMarketingAutomatorActionBarSection(),
        ],
      ),
    );
  }
}
