import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/community_health_needs_assessment_header_section.dart';
import 'sections/community_health_needs_assessment_content_summary_section.dart';
import 'sections/community_health_needs_assessment_primary_content_section.dart';
import 'sections/community_health_needs_assessment_action_bar_section.dart';

class CommunityHealthNeedsAssessmentScreen extends StatelessWidget {
  const CommunityHealthNeedsAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'community_health_needs_assessment',
      title: 'Community Health Needs Assessment',
      child: Column(
        children: const [
          const CommunityHealthNeedsAssessmentHeaderSection(),
          const CommunityHealthNeedsAssessmentContentSummarySection(),
          const CommunityHealthNeedsAssessmentPrimaryContentSection(),
          const CommunityHealthNeedsAssessmentActionBarSection(),
        ],
      ),
    );
  }
}
