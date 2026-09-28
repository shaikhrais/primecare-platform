import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/local_marketing_manager_events_header_section.dart';
import 'sections/local_marketing_manager_events_content_summary_section.dart';
import 'sections/local_marketing_manager_events_primary_content_section.dart';
import 'sections/local_marketing_manager_events_action_bar_section.dart';

class LocalMarketingManagerEventsScreen extends StatelessWidget {
  const LocalMarketingManagerEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'local_marketing_manager_events',
      title: 'Local Marketing Manager Events',
      child: Column(
        children: const [
          const LocalMarketingManagerEventsHeaderSection(),
          const LocalMarketingManagerEventsContentSummarySection(),
          const LocalMarketingManagerEventsPrimaryContentSection(),
          const LocalMarketingManagerEventsActionBarSection(),
        ],
      ),
    );
  }
}
