import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/np_dashboard_header_section.dart';
import 'sections/np_dashboard_summary_cards_section.dart';
import 'sections/np_dashboard_chart_overview_section.dart';
import 'sections/np_dashboard_recent_activity_section.dart';
import 'sections/np_dashboard_quick_actions_section.dart';

class NpDashboardScreen extends StatelessWidget {
  const NpDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'np_dashboard',
      title: 'NpDashboardScreen',
      child: Column(
        children: const [
          const NpDashboardHeaderSection(),
          const NpDashboardSummaryCardsSection(),
          const NpDashboardChartOverviewSection(),
          const NpDashboardRecentActivitySection(),
          const NpDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
