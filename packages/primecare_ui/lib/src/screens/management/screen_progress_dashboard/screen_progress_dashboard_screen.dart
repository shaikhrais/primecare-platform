import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/screen_progress_dashboard_header_section.dart';
import 'sections/screen_progress_dashboard_summary_cards_section.dart';
import 'sections/screen_progress_dashboard_chart_overview_section.dart';
import 'sections/screen_progress_dashboard_recent_activity_section.dart';
import 'sections/screen_progress_dashboard_quick_actions_section.dart';

class ScreenProgressDashboardScreen extends StatelessWidget {
  const ScreenProgressDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'screen_progress_dashboard',
      title: 'ScreenProgressDashboardScreen',
      child: Column(
        children: const [
          const ScreenProgressDashboardHeaderSection(),
          const ScreenProgressDashboardSummaryCardsSection(),
          const ScreenProgressDashboardChartOverviewSection(),
          const ScreenProgressDashboardRecentActivitySection(),
          const ScreenProgressDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
