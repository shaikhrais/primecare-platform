import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/general_manager_analytics_header_section.dart';
import 'sections/general_manager_analytics_filter_bar_section.dart';
import 'sections/general_manager_analytics_metrics_summary_section.dart';
import 'sections/general_manager_analytics_chart_area_section.dart';
import 'sections/general_manager_analytics_export_actions_section.dart';

class GeneralManagerAnalyticsScreen extends StatelessWidget {
  const GeneralManagerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'general_manager_analytics',
      title: 'GeneralManagerAnalyticsScreen',
      child: Column(
        children: const [
          const GeneralManagerAnalyticsHeaderSection(),
          const GeneralManagerAnalyticsFilterBarSection(),
          const GeneralManagerAnalyticsMetricsSummarySection(),
          const GeneralManagerAnalyticsChartAreaSection(),
          const GeneralManagerAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
