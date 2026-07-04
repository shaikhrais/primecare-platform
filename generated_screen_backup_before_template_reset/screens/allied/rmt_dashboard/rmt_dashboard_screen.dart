import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rmt_dashboard_header_section.dart';
import 'sections/rmt_dashboard_summary_cards_section.dart';
import 'sections/rmt_dashboard_chart_overview_section.dart';
import 'sections/rmt_dashboard_recent_activity_section.dart';
import 'sections/rmt_dashboard_quick_actions_section.dart';

class RmtDashboardScreen extends StatelessWidget {
  const RmtDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rmt_dashboard',
      title: 'RmtDashboardScreen',
      child: Column(
        children: const [
          const RmtDashboardHeaderSection(),
          const RmtDashboardSummaryCardsSection(),
          const RmtDashboardChartOverviewSection(),
          const RmtDashboardRecentActivitySection(),
          const RmtDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
