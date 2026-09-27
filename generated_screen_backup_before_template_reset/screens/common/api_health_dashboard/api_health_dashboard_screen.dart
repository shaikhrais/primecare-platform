import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/api_health_dashboard_header_section.dart';
import 'sections/api_health_dashboard_summary_cards_section.dart';
import 'sections/api_health_dashboard_chart_overview_section.dart';
import 'sections/api_health_dashboard_recent_activity_section.dart';
import 'sections/api_health_dashboard_quick_actions_section.dart';

class ApiHealthDashboardScreen extends StatelessWidget {
  const ApiHealthDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'api_health_dashboard',
      title: 'ApiHealthDashboardScreen',
      child: Column(
        children: const [
          const ApiHealthDashboardHeaderSection(),
          const ApiHealthDashboardSummaryCardsSection(),
          const ApiHealthDashboardChartOverviewSection(),
          const ApiHealthDashboardRecentActivitySection(),
          const ApiHealthDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
