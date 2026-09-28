import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/infection_control_dashboard_header_section.dart';
import 'sections/infection_control_dashboard_summary_cards_section.dart';
import 'sections/infection_control_dashboard_chart_overview_section.dart';
import 'sections/infection_control_dashboard_recent_activity_section.dart';
import 'sections/infection_control_dashboard_quick_actions_section.dart';

class InfectionControlDashboardScreen extends StatelessWidget {
  const InfectionControlDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'infection_control_dashboard',
      title: 'Infection Control Dashboard',
      child: Column(
        children: const [
          const InfectionControlDashboardHeaderSection(),
          const InfectionControlDashboardSummaryCardsSection(),
          const InfectionControlDashboardChartOverviewSection(),
          const InfectionControlDashboardRecentActivitySection(),
          const InfectionControlDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
