import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_director_analytics_header_section.dart';
import 'sections/training_director_analytics_filter_bar_section.dart';
import 'sections/training_director_analytics_metrics_summary_section.dart';
import 'sections/training_director_analytics_chart_area_section.dart';
import 'sections/training_director_analytics_export_actions_section.dart';

class TrainingDirectorAnalyticsScreen extends StatelessWidget {
  const TrainingDirectorAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_director_analytics',
      title: 'TrainingDirectorAnalyticsScreen',
      child: Column(
        children: const [
          const TrainingDirectorAnalyticsHeaderSection(),
          const TrainingDirectorAnalyticsFilterBarSection(),
          const TrainingDirectorAnalyticsMetricsSummarySection(),
          const TrainingDirectorAnalyticsChartAreaSection(),
          const TrainingDirectorAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
