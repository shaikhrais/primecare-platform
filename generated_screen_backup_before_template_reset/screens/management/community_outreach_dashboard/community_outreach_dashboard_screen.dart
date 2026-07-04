import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/community_outreach_dashboard_header_section.dart';
import 'sections/community_outreach_dashboard_summary_cards_section.dart';
import 'sections/community_outreach_dashboard_chart_overview_section.dart';
import 'sections/community_outreach_dashboard_recent_activity_section.dart';
import 'sections/community_outreach_dashboard_quick_actions_section.dart';

class CommunityOutreachDashboardScreen extends StatelessWidget {
  const CommunityOutreachDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'community_outreach_dashboard',
      title: 'CommunityOutreachDashboardScreen',
      child: Column(
        children: const [
          const CommunityOutreachDashboardHeaderSection(),
          const CommunityOutreachDashboardSummaryCardsSection(),
          const CommunityOutreachDashboardChartOverviewSection(),
          const CommunityOutreachDashboardRecentActivitySection(),
          const CommunityOutreachDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
