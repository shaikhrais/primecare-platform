import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/dynamic_analytics_header_section.dart';
import 'sections/dynamic_analytics_filter_bar_section.dart';
import 'sections/dynamic_analytics_metrics_summary_section.dart';
import 'sections/dynamic_analytics_chart_area_section.dart';
import 'sections/dynamic_analytics_export_actions_section.dart';

class DynamicAnalyticsScreen extends StatelessWidget {
  const DynamicAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'dynamic_analytics',
      title: 'DynamicScreenAnalyticsScreen',
      child: Column(
        children: const [
          const DynamicAnalyticsHeaderSection(),
          const DynamicAnalyticsFilterBarSection(),
          const DynamicAnalyticsMetricsSummarySection(),
          const DynamicAnalyticsChartAreaSection(),
          const DynamicAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
