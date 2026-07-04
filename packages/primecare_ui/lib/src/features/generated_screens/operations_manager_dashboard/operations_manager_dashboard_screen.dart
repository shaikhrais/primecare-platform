import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/operations_manager_dashboard_header_section.dart';
import 'sections/operations_manager_dashboard_summary_cards_section.dart';
import 'sections/operations_manager_dashboard_chart_overview_section.dart';
import 'sections/operations_manager_dashboard_recent_activity_section.dart';
import 'sections/operations_manager_dashboard_quick_actions_section.dart';

class OperationsManagerDashboardScreen extends StatelessWidget {
  const OperationsManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'operations_manager_dashboard',
      title: 'OperationsManagerDashboardScreen',
      child: Column(
        children: const [
          const OperationsManagerDashboardHeaderSection(),
          const OperationsManagerDashboardSummaryCardsSection(),
          const OperationsManagerDashboardChartOverviewSection(),
          const OperationsManagerDashboardRecentActivitySection(),
          const OperationsManagerDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
