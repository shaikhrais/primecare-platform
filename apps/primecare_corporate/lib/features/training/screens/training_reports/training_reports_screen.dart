import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_reports_header_section.dart';
import 'sections/training_reports_filter_bar_section.dart';
import 'sections/training_reports_metrics_summary_section.dart';
import 'sections/training_reports_chart_area_section.dart';
import 'sections/training_reports_export_actions_section.dart';

class TrainingReportsScreen extends StatelessWidget {
  const TrainingReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_reports',
      title: 'Training Reports',
      child: Column(
        children: const [
          const TrainingReportsHeaderSection(),
          const TrainingReportsFilterBarSection(),
          const TrainingReportsMetricsSummarySection(),
          const TrainingReportsChartAreaSection(),
          const TrainingReportsExportActionsSection(),
        ],
      ),
    );
  }
}
