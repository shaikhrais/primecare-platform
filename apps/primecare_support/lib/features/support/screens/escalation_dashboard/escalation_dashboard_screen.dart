import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/escalation_dashboard_header_section.dart';
import 'sections/escalation_dashboard_summary_cards_section.dart';
import 'sections/escalation_dashboard_chart_overview_section.dart';
import 'sections/escalation_dashboard_recent_activity_section.dart';
import 'sections/escalation_dashboard_quick_actions_section.dart';

class EscalationDashboardScreen extends StatelessWidget {
  const EscalationDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'escalation_dashboard',
      title: 'Escalation Dashboard',
      child: Column(
        children: const [
          const EscalationDashboardHeaderSection(),
          const EscalationDashboardSummaryCardsSection(),
          const EscalationDashboardChartOverviewSection(),
          const EscalationDashboardRecentActivitySection(),
          const EscalationDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
