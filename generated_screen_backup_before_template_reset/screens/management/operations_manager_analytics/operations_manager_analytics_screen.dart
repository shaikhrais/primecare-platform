import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/operations_manager_analytics_header_section.dart';
import 'sections/operations_manager_analytics_filter_bar_section.dart';
import 'sections/operations_manager_analytics_metrics_summary_section.dart';
import 'sections/operations_manager_analytics_chart_area_section.dart';
import 'sections/operations_manager_analytics_export_actions_section.dart';

class OperationsManagerAnalyticsScreen extends StatelessWidget {
  const OperationsManagerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'operations_manager_analytics',
      title: 'OperationsManagerAnalyticsScreen',
      child: Column(
        children: const [
          const OperationsManagerAnalyticsHeaderSection(),
          const OperationsManagerAnalyticsFilterBarSection(),
          const OperationsManagerAnalyticsMetricsSummarySection(),
          const OperationsManagerAnalyticsChartAreaSection(),
          const OperationsManagerAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
