import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/event_and_webinar_manager_header_section.dart';
import 'sections/event_and_webinar_manager_content_summary_section.dart';
import 'sections/event_and_webinar_manager_primary_content_section.dart';
import 'sections/event_and_webinar_manager_action_bar_section.dart';

class EventAndWebinarManagerScreen extends StatelessWidget {
  const EventAndWebinarManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'event_and_webinar_manager',
      title: 'Event And Webinar Manager',
      child: Column(
        children: const [
          const EventAndWebinarManagerHeaderSection(),
          const EventAndWebinarManagerContentSummarySection(),
          const EventAndWebinarManagerPrimaryContentSection(),
          const EventAndWebinarManagerActionBarSection(),
        ],
      ),
    );
  }
}
