import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/operations_manager_reports_header_section.dart';
import 'sections/operations_manager_reports_filter_bar_section.dart';
import 'sections/operations_manager_reports_metrics_summary_section.dart';
import 'sections/operations_manager_reports_chart_area_section.dart';
import 'sections/operations_manager_reports_export_actions_section.dart';

class OperationsManagerReportsScreen extends StatelessWidget {
  const OperationsManagerReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'operations_manager_reports',
      title: 'Operations Manager Reports',
      child: Column(
        children: const [
          const OperationsManagerReportsHeaderSection(),
          const OperationsManagerReportsFilterBarSection(),
          const OperationsManagerReportsMetricsSummarySection(),
          const OperationsManagerReportsChartAreaSection(),
          const OperationsManagerReportsExportActionsSection(),
        ],
      ),
    );
  }
}
