import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_hub_analytics_header_section.dart';
import 'sections/training_hub_analytics_filter_bar_section.dart';
import 'sections/training_hub_analytics_metrics_summary_section.dart';
import 'sections/training_hub_analytics_chart_area_section.dart';
import 'sections/training_hub_analytics_export_actions_section.dart';

class TrainingHubAnalyticsScreen extends StatelessWidget {
  const TrainingHubAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_hub_analytics',
      title: 'TrainingHubAnalyticsScreen',
      child: Column(
        children: const [
          const TrainingHubAnalyticsHeaderSection(),
          const TrainingHubAnalyticsFilterBarSection(),
          const TrainingHubAnalyticsMetricsSummarySection(),
          const TrainingHubAnalyticsChartAreaSection(),
          const TrainingHubAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
