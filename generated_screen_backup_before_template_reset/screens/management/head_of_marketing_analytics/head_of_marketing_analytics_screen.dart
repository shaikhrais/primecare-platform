import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/head_of_marketing_analytics_header_section.dart';
import 'sections/head_of_marketing_analytics_filter_bar_section.dart';
import 'sections/head_of_marketing_analytics_metrics_summary_section.dart';
import 'sections/head_of_marketing_analytics_chart_area_section.dart';
import 'sections/head_of_marketing_analytics_export_actions_section.dart';

class HeadOfMarketingAnalyticsScreen extends StatelessWidget {
  const HeadOfMarketingAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'head_of_marketing_analytics',
      title: 'HeadOfMarketingAnalyticsScreen',
      child: Column(
        children: const [
          const HeadOfMarketingAnalyticsHeaderSection(),
          const HeadOfMarketingAnalyticsFilterBarSection(),
          const HeadOfMarketingAnalyticsMetricsSummarySection(),
          const HeadOfMarketingAnalyticsChartAreaSection(),
          const HeadOfMarketingAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
