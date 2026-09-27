import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/employee_dashboard_header_section.dart';
import 'sections/employee_dashboard_summary_cards_section.dart';
import 'sections/employee_dashboard_chart_overview_section.dart';
import 'sections/employee_dashboard_recent_activity_section.dart';
import 'sections/employee_dashboard_quick_actions_section.dart';

class EmployeeDashboardScreen extends StatelessWidget {
  const EmployeeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'employee_dashboard',
      title: 'EmployeeDashboardScreen',
      child: Column(
        children: const [
          const EmployeeDashboardHeaderSection(),
          const EmployeeDashboardSummaryCardsSection(),
          const EmployeeDashboardChartOverviewSection(),
          const EmployeeDashboardRecentActivitySection(),
          const EmployeeDashboardQuickActionsSection(),
        ],
      ),
    );
  }
}
