import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/support_analytics_header_section.dart';
import 'sections/support_analytics_filter_bar_section.dart';
import 'sections/support_analytics_metrics_summary_section.dart';
import 'sections/support_analytics_chart_area_section.dart';
import 'sections/support_analytics_export_actions_section.dart';

class SupportAnalyticsScreen extends StatelessWidget {
  const SupportAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'support_analytics',
      title: 'SupportAnalyticsScreen',
      child: Column(
        children: const [
          const SupportAnalyticsHeaderSection(),
          const SupportAnalyticsFilterBarSection(),
          const SupportAnalyticsMetricsSummarySection(),
          const SupportAnalyticsChartAreaSection(),
          const SupportAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
