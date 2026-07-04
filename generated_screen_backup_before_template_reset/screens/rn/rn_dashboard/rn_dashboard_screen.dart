import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rn_dashboard_header_section.dart';
import 'sections/rn_dashboard_summary_cards_section.dart';
import 'sections/rn_dashboard_chart_overview_section.dart';
import 'sections/rn_dashboard_recent_activity_section.dart';
import 'sections/rn_dashboard_quick_actions_section.dart';

class RnDashboardScreen extends StatelessWidget {
  const RnDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rn_dashboard',
      title: 'RnDashboardScreen',
      child: Column(
        children: const [
          const RnDashboardHeaderSection(),
          const RnDashboardSummaryCardsSection(),
          const RnDashboardChartOverviewSection(),
          const RnDashboardRecentActivitySection(),
          const RnDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
