import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/community_outreach_follow_ups_header_section.dart';
import 'sections/community_outreach_follow_ups_content_summary_section.dart';
import 'sections/community_outreach_follow_ups_primary_content_section.dart';
import 'sections/community_outreach_follow_ups_action_bar_section.dart';

class CommunityOutreachFollowUpsScreen extends StatelessWidget {
  const CommunityOutreachFollowUpsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'community_outreach_follow_ups',
      title: 'Community Outreach Follow Ups',
      child: Column(
        children: const [
          const CommunityOutreachFollowUpsHeaderSection(),
          const CommunityOutreachFollowUpsContentSummarySection(),
          const CommunityOutreachFollowUpsPrimaryContentSection(),
          const CommunityOutreachFollowUpsActionBarSection(),
        ],
      ),
    );
  }
}
