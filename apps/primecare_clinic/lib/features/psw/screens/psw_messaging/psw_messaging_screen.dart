import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_messaging_header_section.dart';
import 'sections/psw_messaging_content_summary_section.dart';
import 'sections/psw_messaging_primary_content_section.dart';
import 'sections/psw_messaging_action_bar_section.dart';

class PswMessagingScreen extends StatelessWidget {
  const PswMessagingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_messaging',
      title: 'Psw Messaging',
      child: Column(
        children: const [
          const PswMessagingHeaderSection(),
          const PswMessagingContentSummarySection(),
          const PswMessagingPrimaryContentSection(),
          const PswMessagingActionBarSection(),
        ],
      ),
    );
  }
}
