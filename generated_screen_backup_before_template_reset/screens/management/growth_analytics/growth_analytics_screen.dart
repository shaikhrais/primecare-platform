import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/growth_analytics_header_section.dart';
import 'sections/growth_analytics_filter_bar_section.dart';
import 'sections/growth_analytics_metrics_summary_section.dart';
import 'sections/growth_analytics_chart_area_section.dart';
import 'sections/growth_analytics_export_actions_section.dart';

class GrowthAnalyticsScreen extends StatelessWidget {
  const GrowthAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'growth_analytics',
      title: 'GrowthAnalyticsScreen',
      child: Column(
        children: const [
          const GrowthAnalyticsHeaderSection(),
          const GrowthAnalyticsFilterBarSection(),
          const GrowthAnalyticsMetricsSummarySection(),
          const GrowthAnalyticsChartAreaSection(),
          const GrowthAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
