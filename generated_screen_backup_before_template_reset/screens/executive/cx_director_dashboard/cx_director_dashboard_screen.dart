import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cx_director_dashboard_header_section.dart';
import 'sections/cx_director_dashboard_summary_cards_section.dart';
import 'sections/cx_director_dashboard_chart_overview_section.dart';
import 'sections/cx_director_dashboard_recent_activity_section.dart';
import 'sections/cx_director_dashboard_quick_actions_section.dart';

class CxDirectorDashboardScreen extends StatelessWidget {
  const CxDirectorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cx_director_dashboard',
      title: 'CxDirectorDashboardScreen',
      child: Column(
        children: const [
          const CxDirectorDashboardHeaderSection(),
          const CxDirectorDashboardSummaryCardsSection(),
          const CxDirectorDashboardChartOverviewSection(),
          const CxDirectorDashboardRecentActivitySection(),
          const CxDirectorDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
