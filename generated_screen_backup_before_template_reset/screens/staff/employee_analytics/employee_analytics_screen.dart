import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/employee_analytics_header_section.dart';
import 'sections/employee_analytics_filter_bar_section.dart';
import 'sections/employee_analytics_metrics_summary_section.dart';
import 'sections/employee_analytics_chart_area_section.dart';
import 'sections/employee_analytics_export_actions_section.dart';

class EmployeeAnalyticsScreen extends StatelessWidget {
  const EmployeeAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'employee_analytics',
      title: 'Employee Analytics',
      child: Column(
        children: const [
          const EmployeeAnalyticsHeaderSection(),
          const EmployeeAnalyticsFilterBarSection(),
          const EmployeeAnalyticsMetricsSummarySection(),
          const EmployeeAnalyticsChartAreaSection(),
          const EmployeeAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
