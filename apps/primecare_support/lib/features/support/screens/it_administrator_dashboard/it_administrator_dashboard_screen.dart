import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/it_administrator_dashboard_header_section.dart';
import 'sections/it_administrator_dashboard_summary_cards_section.dart';
import 'sections/it_administrator_dashboard_chart_overview_section.dart';
import 'sections/it_administrator_dashboard_recent_activity_section.dart';
import 'sections/it_administrator_dashboard_quick_actions_section.dart';

class ItAdministratorDashboardScreen extends StatelessWidget {
  const ItAdministratorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'it_administrator_dashboard',
      title: 'It Administrator Dashboard',
      child: Column(
        children: const [
          const ItAdministratorDashboardHeaderSection(),
          const ItAdministratorDashboardSummaryCardsSection(),
          const ItAdministratorDashboardChartOverviewSection(),
          const ItAdministratorDashboardRecentActivitySection(),
          const ItAdministratorDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
