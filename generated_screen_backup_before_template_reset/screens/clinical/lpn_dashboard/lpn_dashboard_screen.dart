import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/lpn_dashboard_header_section.dart';
import 'sections/lpn_dashboard_summary_cards_section.dart';
import 'sections/lpn_dashboard_chart_overview_section.dart';
import 'sections/lpn_dashboard_recent_activity_section.dart';
import 'sections/lpn_dashboard_quick_actions_section.dart';

class LpnDashboardScreen extends StatelessWidget {
  const LpnDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'lpn_dashboard',
      title: 'LpnDashboardScreen',
      child: Column(
        children: const [
          const LpnDashboardHeaderSection(),
          const LpnDashboardSummaryCardsSection(),
          const LpnDashboardChartOverviewSection(),
          const LpnDashboardRecentActivitySection(),
          const LpnDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
