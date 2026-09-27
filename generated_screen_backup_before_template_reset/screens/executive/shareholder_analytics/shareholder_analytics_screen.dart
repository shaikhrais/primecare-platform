import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/shareholder_analytics_header_section.dart';
import 'sections/shareholder_analytics_filter_bar_section.dart';
import 'sections/shareholder_analytics_metrics_summary_section.dart';
import 'sections/shareholder_analytics_chart_area_section.dart';
import 'sections/shareholder_analytics_export_actions_section.dart';

class ShareholderAnalyticsScreen extends StatelessWidget {
  const ShareholderAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'shareholder_analytics',
      title: 'ShareholderAnalyticsScreen',
      child: Column(
        children: const [
          const ShareholderAnalyticsHeaderSection(),
          const ShareholderAnalyticsFilterBarSection(),
          const ShareholderAnalyticsMetricsSummarySection(),
          const ShareholderAnalyticsChartAreaSection(),
          const ShareholderAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
