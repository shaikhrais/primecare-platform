import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/local_marketing_manager_dashboard_header_section.dart';
import 'sections/local_marketing_manager_dashboard_summary_cards_section.dart';
import 'sections/local_marketing_manager_dashboard_chart_overview_section.dart';
import 'sections/local_marketing_manager_dashboard_recent_activity_section.dart';
import 'sections/local_marketing_manager_dashboard_quick_actions_section.dart';

class LocalMarketingManagerDashboardScreen extends StatelessWidget {
  const LocalMarketingManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'local_marketing_manager_dashboard',
      title: 'LocalMarketingManagerDashboardScreen',
      child: Column(
        children: const [
          const LocalMarketingManagerDashboardHeaderSection(),
          const LocalMarketingManagerDashboardSummaryCardsSection(),
          const LocalMarketingManagerDashboardChartOverviewSection(),
          const LocalMarketingManagerDashboardRecentActivitySection(),
          const LocalMarketingManagerDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
