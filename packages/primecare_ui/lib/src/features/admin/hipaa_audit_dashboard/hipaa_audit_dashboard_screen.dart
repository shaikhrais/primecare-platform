import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hipaa_audit_dashboard_header_section.dart';
import 'sections/hipaa_audit_dashboard_summary_cards_section.dart';
import 'sections/hipaa_audit_dashboard_chart_overview_section.dart';
import 'sections/hipaa_audit_dashboard_recent_activity_section.dart';
import 'sections/hipaa_audit_dashboard_quick_actions_section.dart';

class HipaaAuditDashboardScreen extends StatelessWidget {
  const HipaaAuditDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hipaa_audit_dashboard',
      title: 'Hipaa Audit Dashboard',
      child: Column(
        children: const [
          const HipaaAuditDashboardHeaderSection(),
          const HipaaAuditDashboardSummaryCardsSection(),
          const HipaaAuditDashboardChartOverviewSection(),
          const HipaaAuditDashboardRecentActivitySection(),
          const HipaaAuditDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
