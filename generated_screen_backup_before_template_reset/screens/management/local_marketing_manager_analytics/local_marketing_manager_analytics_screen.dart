import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/local_marketing_manager_analytics_header_section.dart';
import 'sections/local_marketing_manager_analytics_filter_bar_section.dart';
import 'sections/local_marketing_manager_analytics_metrics_summary_section.dart';
import 'sections/local_marketing_manager_analytics_chart_area_section.dart';
import 'sections/local_marketing_manager_analytics_export_actions_section.dart';

class LocalMarketingManagerAnalyticsScreen extends StatelessWidget {
  const LocalMarketingManagerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'local_marketing_manager_analytics',
      title: 'LocalMarketingManagerAnalyticsScreen',
      child: Column(
        children: const [
          const LocalMarketingManagerAnalyticsHeaderSection(),
          const LocalMarketingManagerAnalyticsFilterBarSection(),
          const LocalMarketingManagerAnalyticsMetricsSummarySection(),
          const LocalMarketingManagerAnalyticsChartAreaSection(),
          const LocalMarketingManagerAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
