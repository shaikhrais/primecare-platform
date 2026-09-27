import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduling_dashboard_header_section.dart';
import 'sections/scheduling_dashboard_summary_cards_section.dart';
import 'sections/scheduling_dashboard_chart_overview_section.dart';
import 'sections/scheduling_dashboard_recent_activity_section.dart';
import 'sections/scheduling_dashboard_quick_actions_section.dart';

class SchedulingDashboardScreen extends StatelessWidget {
  const SchedulingDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduling_dashboard',
      title: 'SchedulingDashboardScreen',
      child: Column(
        children: const [
          const SchedulingDashboardHeaderSection(),
          const SchedulingDashboardSummaryCardsSection(),
          const SchedulingDashboardChartOverviewSection(),
          const SchedulingDashboardRecentActivitySection(),
          const SchedulingDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
