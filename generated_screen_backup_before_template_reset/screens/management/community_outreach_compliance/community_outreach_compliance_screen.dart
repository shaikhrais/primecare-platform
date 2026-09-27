import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/community_outreach_compliance_header_section.dart';
import 'sections/community_outreach_compliance_content_summary_section.dart';
import 'sections/community_outreach_compliance_primary_content_section.dart';
import 'sections/community_outreach_compliance_action_bar_section.dart';

class CommunityOutreachComplianceScreen extends StatelessWidget {
  const CommunityOutreachComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'community_outreach_compliance',
      title: 'CommunityOutreachComplianceScreen',
      child: Column(
        children: const [
          const CommunityOutreachComplianceHeaderSection(),
          const CommunityOutreachComplianceContentSummarySection(),
          const CommunityOutreachCompliancePrimaryContentSection(),
          const CommunityOutreachComplianceActionBarSection(),
        ],
      ),
    );
  }
}
