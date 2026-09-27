import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/community_outreach_programs_header_section.dart';
import 'sections/community_outreach_programs_content_summary_section.dart';
import 'sections/community_outreach_programs_primary_content_section.dart';
import 'sections/community_outreach_programs_action_bar_section.dart';

class CommunityOutreachProgramsScreen extends StatelessWidget {
  const CommunityOutreachProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'community_outreach_programs',
      title: 'Community Outreach Programs',
      child: Column(
        children: const [
          const CommunityOutreachProgramsHeaderSection(),
          const CommunityOutreachProgramsContentSummarySection(),
          const CommunityOutreachProgramsPrimaryContentSection(),
          const CommunityOutreachProgramsActionBarSection(),
        ],
      ),
    );
  }
}
