import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/dynamic_dashboard_header_section.dart';
import 'sections/dynamic_dashboard_summary_cards_section.dart';
import 'sections/dynamic_dashboard_chart_overview_section.dart';
import 'sections/dynamic_dashboard_recent_activity_section.dart';
import 'sections/dynamic_dashboard_quick_actions_section.dart';

class DynamicDashboardScreen extends StatelessWidget {
  const DynamicDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'dynamic_dashboard',
      title: 'Dynamic Dashboard',
      child: Column(
        children: const [
          const DynamicDashboardHeaderSection(),
          const DynamicDashboardSummaryCardsSection(),
          const DynamicDashboardChartOverviewSection(),
          const DynamicDashboardRecentActivitySection(),
          const DynamicDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
