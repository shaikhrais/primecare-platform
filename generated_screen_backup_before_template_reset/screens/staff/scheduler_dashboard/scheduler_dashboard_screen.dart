import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduler_dashboard_header_section.dart';
import 'sections/scheduler_dashboard_summary_cards_section.dart';
import 'sections/scheduler_dashboard_chart_overview_section.dart';
import 'sections/scheduler_dashboard_recent_activity_section.dart';
import 'sections/scheduler_dashboard_quick_actions_section.dart';

class SchedulerDashboardScreen extends StatelessWidget {
  const SchedulerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduler_dashboard',
      title: 'SchedulerDashboardScreen',
      child: Column(
        children: const [
          const SchedulerDashboardHeaderSection(),
          const SchedulerDashboardSummaryCardsSection(),
          const SchedulerDashboardChartOverviewSection(),
          const SchedulerDashboardRecentActivitySection(),
          const SchedulerDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
