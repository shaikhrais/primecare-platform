import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/head_of_bus_dev_analytics_header_section.dart';
import 'sections/head_of_bus_dev_analytics_filter_bar_section.dart';
import 'sections/head_of_bus_dev_analytics_metrics_summary_section.dart';
import 'sections/head_of_bus_dev_analytics_chart_area_section.dart';
import 'sections/head_of_bus_dev_analytics_export_actions_section.dart';

class HeadOfBusDevAnalyticsScreen extends StatelessWidget {
  const HeadOfBusDevAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'head_of_bus_dev_analytics',
      title: 'HeadOfBusDevAnalyticsScreen',
      child: Column(
        children: const [
          const HeadOfBusDevAnalyticsHeaderSection(),
          const HeadOfBusDevAnalyticsFilterBarSection(),
          const HeadOfBusDevAnalyticsMetricsSummarySection(),
          const HeadOfBusDevAnalyticsChartAreaSection(),
          const HeadOfBusDevAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
