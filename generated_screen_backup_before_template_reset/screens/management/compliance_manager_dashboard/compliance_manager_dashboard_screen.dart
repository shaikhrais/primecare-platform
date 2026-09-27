import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/compliance_manager_dashboard_header_section.dart';
import 'sections/compliance_manager_dashboard_summary_cards_section.dart';
import 'sections/compliance_manager_dashboard_chart_overview_section.dart';
import 'sections/compliance_manager_dashboard_recent_activity_section.dart';
import 'sections/compliance_manager_dashboard_quick_actions_section.dart';

class ComplianceManagerDashboardScreen extends StatelessWidget {
  const ComplianceManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'compliance_manager_dashboard',
      title: 'ComplianceManagerDashboardScreen',
      child: Column(
        children: const [
          const ComplianceManagerDashboardHeaderSection(),
          const ComplianceManagerDashboardSummaryCardsSection(),
          const ComplianceManagerDashboardChartOverviewSection(),
          const ComplianceManagerDashboardRecentActivitySection(),
          const ComplianceManagerDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
