import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/governance_officer_dashboard_header_section.dart';
import 'sections/governance_officer_dashboard_summary_cards_section.dart';
import 'sections/governance_officer_dashboard_chart_overview_section.dart';
import 'sections/governance_officer_dashboard_recent_activity_section.dart';
import 'sections/governance_officer_dashboard_quick_actions_section.dart';

class GovernanceOfficerDashboardScreen extends StatelessWidget {
  const GovernanceOfficerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'governance_officer_dashboard',
      title: 'GovernanceOfficerDashboardScreen',
      child: Column(
        children: const [
          const GovernanceOfficerDashboardHeaderSection(),
          const GovernanceOfficerDashboardSummaryCardsSection(),
          const GovernanceOfficerDashboardChartOverviewSection(),
          const GovernanceOfficerDashboardRecentActivitySection(),
          const GovernanceOfficerDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
