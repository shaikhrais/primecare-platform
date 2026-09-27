import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scrum_master_analytics_header_section.dart';
import 'sections/scrum_master_analytics_filter_bar_section.dart';
import 'sections/scrum_master_analytics_metrics_summary_section.dart';
import 'sections/scrum_master_analytics_chart_area_section.dart';
import 'sections/scrum_master_analytics_export_actions_section.dart';

class ScrumMasterAnalyticsScreen extends StatelessWidget {
  const ScrumMasterAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scrum_master_analytics',
      title: 'ScrumMasterAnalyticsScreen',
      child: Column(
        children: const [
          const ScrumMasterAnalyticsHeaderSection(),
          const ScrumMasterAnalyticsFilterBarSection(),
          const ScrumMasterAnalyticsMetricsSummarySection(),
          const ScrumMasterAnalyticsChartAreaSection(),
          const ScrumMasterAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
