import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/audit_dashboard_header_section.dart';
import 'sections/audit_dashboard_summary_cards_section.dart';
import 'sections/audit_dashboard_chart_overview_section.dart';
import 'sections/audit_dashboard_recent_activity_section.dart';
import 'sections/audit_dashboard_quick_actions_section.dart';

class AuditDashboardScreen extends StatelessWidget {
  const AuditDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'audit_dashboard',
      title: 'Audit Dashboard',
      child: Column(
        children: const [
          const AuditDashboardHeaderSection(),
          const AuditDashboardSummaryCardsSection(),
          const AuditDashboardChartOverviewSection(),
          const AuditDashboardRecentActivitySection(),
          const AuditDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
