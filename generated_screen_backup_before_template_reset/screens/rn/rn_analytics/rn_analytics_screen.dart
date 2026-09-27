import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rn_analytics_header_section.dart';
import 'sections/rn_analytics_filter_bar_section.dart';
import 'sections/rn_analytics_metrics_summary_section.dart';
import 'sections/rn_analytics_chart_area_section.dart';
import 'sections/rn_analytics_export_actions_section.dart';

class RnAnalyticsScreen extends StatelessWidget {
  const RnAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rn_analytics',
      title: 'RnAnalyticsScreen',
      child: Column(
        children: const [
          const RnAnalyticsHeaderSection(),
          const RnAnalyticsFilterBarSection(),
          const RnAnalyticsMetricsSummarySection(),
          const RnAnalyticsChartAreaSection(),
          const RnAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
