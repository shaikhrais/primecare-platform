import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/campaign_performance_dashboard_header_section.dart';
import 'sections/campaign_performance_dashboard_summary_cards_section.dart';
import 'sections/campaign_performance_dashboard_chart_overview_section.dart';
import 'sections/campaign_performance_dashboard_recent_activity_section.dart';
import 'sections/campaign_performance_dashboard_quick_actions_section.dart';

class CampaignPerformanceDashboardScreen extends StatelessWidget {
  const CampaignPerformanceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'campaign_performance_dashboard',
      title: 'Campaign Performance Dashboard',
      child: Column(
        children: const [
          const CampaignPerformanceDashboardHeaderSection(),
          const CampaignPerformanceDashboardSummaryCardsSection(),
          const CampaignPerformanceDashboardChartOverviewSection(),
          const CampaignPerformanceDashboardRecentActivitySection(),
          const CampaignPerformanceDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
