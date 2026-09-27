import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_analytics_header_section.dart';
import 'sections/training_analytics_filter_bar_section.dart';
import 'sections/training_analytics_metrics_summary_section.dart';
import 'sections/training_analytics_chart_area_section.dart';
import 'sections/training_analytics_export_actions_section.dart';

class TrainingAnalyticsScreen extends StatelessWidget {
  const TrainingAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_analytics',
      title: 'Training Analytics',
      child: Column(
        children: const [
          const TrainingAnalyticsHeaderSection(),
          const TrainingAnalyticsFilterBarSection(),
          const TrainingAnalyticsMetricsSummarySection(),
          const TrainingAnalyticsChartAreaSection(),
          const TrainingAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
