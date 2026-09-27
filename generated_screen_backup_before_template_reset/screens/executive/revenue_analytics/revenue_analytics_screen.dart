import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/revenue_analytics_header_section.dart';
import 'sections/revenue_analytics_filter_bar_section.dart';
import 'sections/revenue_analytics_metrics_summary_section.dart';
import 'sections/revenue_analytics_chart_area_section.dart';
import 'sections/revenue_analytics_export_actions_section.dart';

class RevenueAnalyticsScreen extends StatelessWidget {
  const RevenueAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'revenue_analytics',
      title: 'RevenueAnalyticsScreen',
      child: Column(
        children: const [
          const RevenueAnalyticsHeaderSection(),
          const RevenueAnalyticsFilterBarSection(),
          const RevenueAnalyticsMetricsSummarySection(),
          const RevenueAnalyticsChartAreaSection(),
          const RevenueAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
