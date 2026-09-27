import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_expansion_manager_dashboard_header_section.dart';
import 'sections/territory_expansion_manager_dashboard_summary_cards_section.dart';
import 'sections/territory_expansion_manager_dashboard_chart_overview_section.dart';
import 'sections/territory_expansion_manager_dashboard_recent_activity_section.dart';
import 'sections/territory_expansion_manager_dashboard_quick_actions_section.dart';

class TerritoryExpansionManagerDashboardScreen extends StatelessWidget {
  const TerritoryExpansionManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_expansion_manager_dashboard',
      title: 'TerritoryExpansionManagerDashboardScreen',
      child: Column(
        children: const [
          const TerritoryExpansionManagerDashboardHeaderSection(),
          const TerritoryExpansionManagerDashboardSummaryCardsSection(),
          const TerritoryExpansionManagerDashboardChartOverviewSection(),
          const TerritoryExpansionManagerDashboardRecentActivitySection(),
          const TerritoryExpansionManagerDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
