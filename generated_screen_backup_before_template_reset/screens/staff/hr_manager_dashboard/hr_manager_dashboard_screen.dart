import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_manager_dashboard_header_section.dart';
import 'sections/hr_manager_dashboard_summary_cards_section.dart';
import 'sections/hr_manager_dashboard_chart_overview_section.dart';
import 'sections/hr_manager_dashboard_recent_activity_section.dart';
import 'sections/hr_manager_dashboard_quick_actions_section.dart';

class HrManagerDashboardScreen extends StatelessWidget {
  const HrManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_manager_dashboard',
      title: 'HrManagerDashboardScreen',
      child: Column(
        children: const [
          const HrManagerDashboardHeaderSection(),
          const HrManagerDashboardSummaryCardsSection(),
          const HrManagerDashboardChartOverviewSection(),
          const HrManagerDashboardRecentActivitySection(),
          const HrManagerDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
