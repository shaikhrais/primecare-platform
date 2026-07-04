import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_director_dashboard_header_section.dart';
import 'sections/hr_director_dashboard_summary_cards_section.dart';
import 'sections/hr_director_dashboard_chart_overview_section.dart';
import 'sections/hr_director_dashboard_recent_activity_section.dart';
import 'sections/hr_director_dashboard_quick_actions_section.dart';

class HrDirectorDashboardScreen extends StatelessWidget {
  const HrDirectorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_director_dashboard',
      title: 'HrDirectorDashboardScreen',
      child: Column(
        children: const [
          const HrDirectorDashboardHeaderSection(),
          const HrDirectorDashboardSummaryCardsSection(),
          const HrDirectorDashboardChartOverviewSection(),
          const HrDirectorDashboardRecentActivitySection(),
          const HrDirectorDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
