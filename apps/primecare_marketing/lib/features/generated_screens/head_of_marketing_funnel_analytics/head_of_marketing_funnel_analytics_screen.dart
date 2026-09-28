import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/head_of_marketing_funnel_analytics_header_section.dart';
import 'sections/head_of_marketing_funnel_analytics_filter_bar_section.dart';
import 'sections/head_of_marketing_funnel_analytics_metrics_summary_section.dart';
import 'sections/head_of_marketing_funnel_analytics_chart_area_section.dart';
import 'sections/head_of_marketing_funnel_analytics_export_actions_section.dart';

class HeadOfMarketingFunnelAnalyticsScreen extends StatelessWidget {
  const HeadOfMarketingFunnelAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'head_of_marketing_funnel_analytics',
      title: 'Head Of Marketing Funnel Analytics',
      child: Column(
        children: const [
          const HeadOfMarketingFunnelAnalyticsHeaderSection(),
          const HeadOfMarketingFunnelAnalyticsFilterBarSection(),
          const HeadOfMarketingFunnelAnalyticsMetricsSummarySection(),
          const HeadOfMarketingFunnelAnalyticsChartAreaSection(),
          const HeadOfMarketingFunnelAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
