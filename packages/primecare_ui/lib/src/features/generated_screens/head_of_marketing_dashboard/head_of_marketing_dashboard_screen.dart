import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/head_of_marketing_dashboard_header_section.dart';
import 'sections/head_of_marketing_dashboard_summary_cards_section.dart';
import 'sections/head_of_marketing_dashboard_chart_overview_section.dart';
import 'sections/head_of_marketing_dashboard_recent_activity_section.dart';
import 'sections/head_of_marketing_dashboard_quick_actions_section.dart';

class HeadOfMarketingDashboardScreen extends StatelessWidget {
  const HeadOfMarketingDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'head_of_marketing_dashboard',
      title: 'HeadOfMarketingDashboardScreen',
      child: Column(
        children: const [
          const HeadOfMarketingDashboardHeaderSection(),
          const HeadOfMarketingDashboardSummaryCardsSection(),
          const HeadOfMarketingDashboardChartOverviewSection(),
          const HeadOfMarketingDashboardRecentActivitySection(),
          const HeadOfMarketingDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
