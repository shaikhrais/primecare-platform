import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/pediatric_dashboard_header_section.dart';
import 'sections/pediatric_dashboard_summary_cards_section.dart';
import 'sections/pediatric_dashboard_chart_overview_section.dart';
import 'sections/pediatric_dashboard_recent_activity_section.dart';
import 'sections/pediatric_dashboard_quick_actions_section.dart';

class PediatricDashboardScreen extends StatelessWidget {
  const PediatricDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'pediatric_dashboard',
      title: 'PediatricDashboardScreen',
      child: Column(
        children: const [
          const PediatricDashboardHeaderSection(),
          const PediatricDashboardSummaryCardsSection(),
          const PediatricDashboardChartOverviewSection(),
          const PediatricDashboardRecentActivitySection(),
          const PediatricDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
