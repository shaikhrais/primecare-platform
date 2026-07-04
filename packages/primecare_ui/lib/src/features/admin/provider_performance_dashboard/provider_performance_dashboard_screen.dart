import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/provider_performance_dashboard_header_section.dart';
import 'sections/provider_performance_dashboard_summary_cards_section.dart';
import 'sections/provider_performance_dashboard_chart_overview_section.dart';
import 'sections/provider_performance_dashboard_recent_activity_section.dart';
import 'sections/provider_performance_dashboard_quick_actions_section.dart';

class ProviderPerformanceDashboardScreen extends StatelessWidget {
  const ProviderPerformanceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'provider_performance_dashboard',
      title: 'Provider Performance Dashboard',
      child: Column(
        children: const [
          const ProviderPerformanceDashboardHeaderSection(),
          const ProviderPerformanceDashboardSummaryCardsSection(),
          const ProviderPerformanceDashboardChartOverviewSection(),
          const ProviderPerformanceDashboardRecentActivitySection(),
          const ProviderPerformanceDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
