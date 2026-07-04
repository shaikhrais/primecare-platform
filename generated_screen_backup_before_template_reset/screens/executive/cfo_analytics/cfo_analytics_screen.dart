import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cfo_analytics_header_section.dart';
import 'sections/cfo_analytics_filter_bar_section.dart';
import 'sections/cfo_analytics_metrics_summary_section.dart';
import 'sections/cfo_analytics_chart_area_section.dart';
import 'sections/cfo_analytics_export_actions_section.dart';

class CfoAnalyticsScreen extends StatelessWidget {
  const CfoAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cfo_analytics',
      title: 'CfoAnalyticsScreen',
      child: Column(
        children: const [
          const CfoAnalyticsHeaderSection(),
          const CfoAnalyticsFilterBarSection(),
          const CfoAnalyticsMetricsSummarySection(),
          const CfoAnalyticsChartAreaSection(),
          const CfoAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
