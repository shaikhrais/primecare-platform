import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/regional_manager_ontario_dashboard_header_section.dart';
import 'sections/regional_manager_ontario_dashboard_summary_cards_section.dart';
import 'sections/regional_manager_ontario_dashboard_chart_overview_section.dart';
import 'sections/regional_manager_ontario_dashboard_recent_activity_section.dart';
import 'sections/regional_manager_ontario_dashboard_quick_actions_section.dart';

class RegionalManagerOntarioDashboardScreen extends StatelessWidget {
  const RegionalManagerOntarioDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'regional_manager_ontario_dashboard',
      title: 'Regional Manager Ontario Dashboard',
      child: Column(
        children: const [
          const RegionalManagerOntarioDashboardHeaderSection(),
          const RegionalManagerOntarioDashboardSummaryCardsSection(),
          const RegionalManagerOntarioDashboardChartOverviewSection(),
          const RegionalManagerOntarioDashboardRecentActivitySection(),
          const RegionalManagerOntarioDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
