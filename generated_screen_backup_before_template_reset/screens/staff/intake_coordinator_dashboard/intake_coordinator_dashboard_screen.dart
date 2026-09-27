import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/intake_coordinator_dashboard_header_section.dart';
import 'sections/intake_coordinator_dashboard_summary_cards_section.dart';
import 'sections/intake_coordinator_dashboard_chart_overview_section.dart';
import 'sections/intake_coordinator_dashboard_recent_activity_section.dart';
import 'sections/intake_coordinator_dashboard_quick_actions_section.dart';

class IntakeCoordinatorDashboardScreen extends StatelessWidget {
  const IntakeCoordinatorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'intake_coordinator_dashboard',
      title: 'IntakeCoordinatorDashboardScreen',
      child: Column(
        children: const [
          const IntakeCoordinatorDashboardHeaderSection(),
          const IntakeCoordinatorDashboardSummaryCardsSection(),
          const IntakeCoordinatorDashboardChartOverviewSection(),
          const IntakeCoordinatorDashboardRecentActivitySection(),
          const IntakeCoordinatorDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
