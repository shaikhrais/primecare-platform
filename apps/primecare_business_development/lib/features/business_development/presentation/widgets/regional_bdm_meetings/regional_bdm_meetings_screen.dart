import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/regional_bdm_meetings_header_section.dart';
import 'sections/regional_bdm_meetings_content_summary_section.dart';
import 'sections/regional_bdm_meetings_primary_content_section.dart';
import 'sections/regional_bdm_meetings_action_bar_section.dart';

class RegionalBdmMeetingsScreen extends StatelessWidget {
  const RegionalBdmMeetingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'regional_bdm_meetings',
      title: 'Regional Bdm Meetings',
      child: Column(
        children: const [
          const RegionalBdmMeetingsHeaderSection(),
          const RegionalBdmMeetingsContentSummarySection(),
          const RegionalBdmMeetingsPrimaryContentSection(),
          const RegionalBdmMeetingsActionBarSection(),
        ],
      ),
    );
  }
}
