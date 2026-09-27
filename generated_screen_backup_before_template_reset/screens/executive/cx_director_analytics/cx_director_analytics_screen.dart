import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cx_director_analytics_header_section.dart';
import 'sections/cx_director_analytics_filter_bar_section.dart';
import 'sections/cx_director_analytics_metrics_summary_section.dart';
import 'sections/cx_director_analytics_chart_area_section.dart';
import 'sections/cx_director_analytics_export_actions_section.dart';

class CxDirectorAnalyticsScreen extends StatelessWidget {
  const CxDirectorAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cx_director_analytics',
      title: 'CxDirectorAnalyticsScreen',
      child: Column(
        children: const [
          const CxDirectorAnalyticsHeaderSection(),
          const CxDirectorAnalyticsFilterBarSection(),
          const CxDirectorAnalyticsMetricsSummarySection(),
          const CxDirectorAnalyticsChartAreaSection(),
          const CxDirectorAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
