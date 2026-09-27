import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/predictive_analytics_dashboard_header_section.dart';
import 'sections/predictive_analytics_dashboard_summary_cards_section.dart';
import 'sections/predictive_analytics_dashboard_chart_overview_section.dart';
import 'sections/predictive_analytics_dashboard_recent_activity_section.dart';
import 'sections/predictive_analytics_dashboard_quick_actions_section.dart';

class PredictiveAnalyticsDashboardScreen extends StatelessWidget {
  const PredictiveAnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'predictive_analytics_dashboard',
      title: 'Predictive Analytics Dashboard',
      child: Column(
        children: const [
          const PredictiveAnalyticsDashboardHeaderSection(),
          const PredictiveAnalyticsDashboardSummaryCardsSection(),
          const PredictiveAnalyticsDashboardChartOverviewSection(),
          const PredictiveAnalyticsDashboardRecentActivitySection(),
          const PredictiveAnalyticsDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
