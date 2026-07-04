import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/role_coverage_dashboard_header_section.dart';
import 'sections/role_coverage_dashboard_summary_cards_section.dart';
import 'sections/role_coverage_dashboard_chart_overview_section.dart';
import 'sections/role_coverage_dashboard_recent_activity_section.dart';
import 'sections/role_coverage_dashboard_quick_actions_section.dart';

class RoleCoverageDashboardScreen extends StatelessWidget {
  const RoleCoverageDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'role_coverage_dashboard',
      title: 'RoleCoverageDashboardScreen',
      child: Column(
        children: const [
          const RoleCoverageDashboardHeaderSection(),
          const RoleCoverageDashboardSummaryCardsSection(),
          const RoleCoverageDashboardChartOverviewSection(),
          const RoleCoverageDashboardRecentActivitySection(),
          const RoleCoverageDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
