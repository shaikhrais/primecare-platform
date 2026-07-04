import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_hiring_dashboard_header_section.dart';
import 'sections/hr_hiring_dashboard_summary_cards_section.dart';
import 'sections/hr_hiring_dashboard_chart_overview_section.dart';
import 'sections/hr_hiring_dashboard_recent_activity_section.dart';
import 'sections/hr_hiring_dashboard_quick_actions_section.dart';

class HrHiringDashboardScreen extends StatelessWidget {
  const HrHiringDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_hiring_dashboard',
      title: 'HrHiringDashboardScreen',
      child: Column(
        children: const [
          const HrHiringDashboardHeaderSection(),
          const HrHiringDashboardSummaryCardsSection(),
          const HrHiringDashboardChartOverviewSection(),
          const HrHiringDashboardRecentActivitySection(),
          const HrHiringDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
