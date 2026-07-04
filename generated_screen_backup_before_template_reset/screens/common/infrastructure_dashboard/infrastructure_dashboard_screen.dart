import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/infrastructure_dashboard_header_section.dart';
import 'sections/infrastructure_dashboard_summary_cards_section.dart';
import 'sections/infrastructure_dashboard_chart_overview_section.dart';
import 'sections/infrastructure_dashboard_recent_activity_section.dart';
import 'sections/infrastructure_dashboard_quick_actions_section.dart';

class InfrastructureDashboardScreen extends StatelessWidget {
  const InfrastructureDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'infrastructure_dashboard',
      title: 'InfrastructureDashboardScreen',
      child: Column(
        children: const [
          const InfrastructureDashboardHeaderSection(),
          const InfrastructureDashboardSummaryCardsSection(),
          const InfrastructureDashboardChartOverviewSection(),
          const InfrastructureDashboardRecentActivitySection(),
          const InfrastructureDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
