import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/compliance_dashboard_header_section.dart';
import 'sections/compliance_dashboard_summary_cards_section.dart';
import 'sections/compliance_dashboard_chart_overview_section.dart';
import 'sections/compliance_dashboard_recent_activity_section.dart';
import 'sections/compliance_dashboard_quick_actions_section.dart';

class ComplianceDashboardScreen extends StatelessWidget {
  const ComplianceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'compliance_dashboard',
      title: 'ComplianceDashboardScreen',
      child: Column(
        children: const [
          const ComplianceDashboardHeaderSection(),
          const ComplianceDashboardSummaryCardsSection(),
          const ComplianceDashboardChartOverviewSection(),
          const ComplianceDashboardRecentActivitySection(),
          const ComplianceDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
