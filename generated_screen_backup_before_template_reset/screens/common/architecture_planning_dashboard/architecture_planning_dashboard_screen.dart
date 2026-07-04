import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/architecture_planning_dashboard_header_section.dart';
import 'sections/architecture_planning_dashboard_summary_cards_section.dart';
import 'sections/architecture_planning_dashboard_chart_overview_section.dart';
import 'sections/architecture_planning_dashboard_recent_activity_section.dart';
import 'sections/architecture_planning_dashboard_quick_actions_section.dart';

class ArchitecturePlanningDashboardScreen extends StatelessWidget {
  const ArchitecturePlanningDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'architecture_planning_dashboard',
      title: 'ArchitecturePlanningDashboardScreen',
      child: Column(
        children: const [
          const ArchitecturePlanningDashboardHeaderSection(),
          const ArchitecturePlanningDashboardSummaryCardsSection(),
          const ArchitecturePlanningDashboardChartOverviewSection(),
          const ArchitecturePlanningDashboardRecentActivitySection(),
          const ArchitecturePlanningDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
