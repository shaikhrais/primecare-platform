import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/chiropractor_analytics_header_section.dart';
import 'sections/chiropractor_analytics_filter_bar_section.dart';
import 'sections/chiropractor_analytics_metrics_summary_section.dart';
import 'sections/chiropractor_analytics_chart_area_section.dart';
import 'sections/chiropractor_analytics_export_actions_section.dart';

class ChiropractorAnalyticsScreen extends StatelessWidget {
  const ChiropractorAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'chiropractor_analytics',
      title: 'ChiropractorAnalyticsScreen',
      child: Column(
        children: const [
          const ChiropractorAnalyticsHeaderSection(),
          const ChiropractorAnalyticsFilterBarSection(),
          const ChiropractorAnalyticsMetricsSummarySection(),
          const ChiropractorAnalyticsChartAreaSection(),
          const ChiropractorAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
