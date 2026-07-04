import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/unknown_dashboard_header_section.dart';
import 'sections/unknown_dashboard_summary_cards_section.dart';
import 'sections/unknown_dashboard_chart_overview_section.dart';
import 'sections/unknown_dashboard_recent_activity_section.dart';
import 'sections/unknown_dashboard_quick_actions_section.dart';

class UnknownDashboardScreen extends StatelessWidget {
  const UnknownDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'unknown_dashboard',
      title: 'Unknown Dashboard',
      child: Column(
        children: const [
          const UnknownDashboardHeaderSection(),
          const UnknownDashboardSummaryCardsSection(),
          const UnknownDashboardChartOverviewSection(),
          const UnknownDashboardRecentActivitySection(),
          const UnknownDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
