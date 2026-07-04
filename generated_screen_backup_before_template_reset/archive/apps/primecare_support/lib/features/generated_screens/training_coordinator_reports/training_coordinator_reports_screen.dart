import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_coordinator_reports_header_section.dart';
import 'sections/training_coordinator_reports_filter_bar_section.dart';
import 'sections/training_coordinator_reports_metrics_summary_section.dart';
import 'sections/training_coordinator_reports_chart_area_section.dart';
import 'sections/training_coordinator_reports_export_actions_section.dart';

class TrainingCoordinatorReportsScreen extends StatelessWidget {
  const TrainingCoordinatorReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_coordinator_reports',
      title: 'Training Coordinator Reports',
      child: Column(
        children: const [
          const TrainingCoordinatorReportsHeaderSection(),
          const TrainingCoordinatorReportsFilterBarSection(),
          const TrainingCoordinatorReportsMetricsSummarySection(),
          const TrainingCoordinatorReportsChartAreaSection(),
          const TrainingCoordinatorReportsExportActionsSection(),
        ],
      ),
    );
  }
}
