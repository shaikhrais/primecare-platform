import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/community_outreach_contacts_header_section.dart';
import 'sections/community_outreach_contacts_content_summary_section.dart';
import 'sections/community_outreach_contacts_primary_content_section.dart';
import 'sections/community_outreach_contacts_action_bar_section.dart';

class CommunityOutreachContactsScreen extends StatelessWidget {
  const CommunityOutreachContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'community_outreach_contacts',
      title: 'Community Outreach Contacts',
      child: Column(
        children: const [
          const CommunityOutreachContactsHeaderSection(),
          const CommunityOutreachContactsContentSummarySection(),
          const CommunityOutreachContactsPrimaryContentSection(),
          const CommunityOutreachContactsActionBarSection(),
        ],
      ),
    );
  }
}
