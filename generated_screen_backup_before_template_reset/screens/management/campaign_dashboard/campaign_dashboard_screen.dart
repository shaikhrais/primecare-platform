import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/campaign_dashboard_header_section.dart';
import 'sections/campaign_dashboard_summary_cards_section.dart';
import 'sections/campaign_dashboard_chart_overview_section.dart';
import 'sections/campaign_dashboard_recent_activity_section.dart';
import 'sections/campaign_dashboard_quick_actions_section.dart';

class CampaignDashboardScreen extends StatelessWidget {
  const CampaignDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'campaign_dashboard',
      title: 'CampaignDashboardScreen',
      child: Column(
        children: const [
          const CampaignDashboardHeaderSection(),
          const CampaignDashboardSummaryCardsSection(),
          const CampaignDashboardChartOverviewSection(),
          const CampaignDashboardRecentActivitySection(),
          const CampaignDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
