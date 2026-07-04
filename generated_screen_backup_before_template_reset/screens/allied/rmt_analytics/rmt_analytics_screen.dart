import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rmt_analytics_header_section.dart';
import 'sections/rmt_analytics_filter_bar_section.dart';
import 'sections/rmt_analytics_metrics_summary_section.dart';
import 'sections/rmt_analytics_chart_area_section.dart';
import 'sections/rmt_analytics_export_actions_section.dart';

class RmtAnalyticsScreen extends StatelessWidget {
  const RmtAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rmt_analytics',
      title: 'RmtAnalyticsScreen',
      child: Column(
        children: const [
          const RmtAnalyticsHeaderSection(),
          const RmtAnalyticsFilterBarSection(),
          const RmtAnalyticsMetricsSummarySection(),
          const RmtAnalyticsChartAreaSection(),
          const RmtAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
