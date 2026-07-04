import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rn_field_supervisor_dashboard_header_section.dart';
import 'sections/rn_field_supervisor_dashboard_summary_cards_section.dart';
import 'sections/rn_field_supervisor_dashboard_chart_overview_section.dart';
import 'sections/rn_field_supervisor_dashboard_recent_activity_section.dart';
import 'sections/rn_field_supervisor_dashboard_quick_actions_section.dart';

class RnFieldSupervisorDashboardScreen extends StatelessWidget {
  const RnFieldSupervisorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rn_field_supervisor_dashboard',
      title: 'RnFieldSupervisorDashboardScreen',
      child: Column(
        children: const [
          const RnFieldSupervisorDashboardHeaderSection(),
          const RnFieldSupervisorDashboardSummaryCardsSection(),
          const RnFieldSupervisorDashboardChartOverviewSection(),
          const RnFieldSupervisorDashboardRecentActivitySection(),
          const RnFieldSupervisorDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
