import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_director_reports_header_section.dart';
import 'sections/training_director_reports_filter_bar_section.dart';
import 'sections/training_director_reports_metrics_summary_section.dart';
import 'sections/training_director_reports_chart_area_section.dart';
import 'sections/training_director_reports_export_actions_section.dart';

class TrainingDirectorReportsScreen extends StatelessWidget {
  const TrainingDirectorReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_director_reports',
      title: 'Training Director Reports',
      child: Column(
        children: const [
          const TrainingDirectorReportsHeaderSection(),
          const TrainingDirectorReportsFilterBarSection(),
          const TrainingDirectorReportsMetricsSummarySection(),
          const TrainingDirectorReportsChartAreaSection(),
          const TrainingDirectorReportsExportActionsSection(),
        ],
      ),
    );
  }
}
