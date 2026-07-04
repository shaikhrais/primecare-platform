import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/community_outreach_partnerships_header_section.dart';
import 'sections/community_outreach_partnerships_content_summary_section.dart';
import 'sections/community_outreach_partnerships_primary_content_section.dart';
import 'sections/community_outreach_partnerships_action_bar_section.dart';

class CommunityOutreachPartnershipsScreen extends StatelessWidget {
  const CommunityOutreachPartnershipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'community_outreach_partnerships',
      title: 'Community Outreach Partnerships',
      child: Column(
        children: const [
          const CommunityOutreachPartnershipsHeaderSection(),
          const CommunityOutreachPartnershipsContentSummarySection(),
          const CommunityOutreachPartnershipsPrimaryContentSection(),
          const CommunityOutreachPartnershipsActionBarSection(),
        ],
      ),
    );
  }
}
