import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/community_outreach_events_header_section.dart';
import 'sections/community_outreach_events_content_summary_section.dart';
import 'sections/community_outreach_events_primary_content_section.dart';
import 'sections/community_outreach_events_action_bar_section.dart';

class CommunityOutreachEventsScreen extends StatelessWidget {
  const CommunityOutreachEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'community_outreach_events',
      title: 'Community Outreach Events',
      child: Column(
        children: const [
          const CommunityOutreachEventsHeaderSection(),
          const CommunityOutreachEventsContentSummarySection(),
          const CommunityOutreachEventsPrimaryContentSection(),
          const CommunityOutreachEventsActionBarSection(),
        ],
      ),
    );
  }
}
