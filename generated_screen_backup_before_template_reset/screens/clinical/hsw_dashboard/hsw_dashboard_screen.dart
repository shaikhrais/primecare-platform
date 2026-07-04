import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hsw_dashboard_header_section.dart';
import 'sections/hsw_dashboard_summary_cards_section.dart';
import 'sections/hsw_dashboard_chart_overview_section.dart';
import 'sections/hsw_dashboard_recent_activity_section.dart';
import 'sections/hsw_dashboard_quick_actions_section.dart';

class HswDashboardScreen extends StatelessWidget {
  const HswDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hsw_dashboard',
      title: 'HswDashboardScreen',
      child: Column(
        children: const [
          const HswDashboardHeaderSection(),
          const HswDashboardSummaryCardsSection(),
          const HswDashboardChartOverviewSection(),
          const HswDashboardRecentActivitySection(),
          const HswDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
