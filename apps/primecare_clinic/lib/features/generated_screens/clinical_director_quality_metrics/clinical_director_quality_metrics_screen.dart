import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinical_director_quality_metrics_header_section.dart';
import 'sections/clinical_director_quality_metrics_filter_bar_section.dart';
import 'sections/clinical_director_quality_metrics_metrics_summary_section.dart';
import 'sections/clinical_director_quality_metrics_chart_area_section.dart';
import 'sections/clinical_director_quality_metrics_export_actions_section.dart';

class ClinicalDirectorQualityMetricsScreen extends StatelessWidget {
  const ClinicalDirectorQualityMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinical_director_quality_metrics',
      title: 'Clinical Director Quality Metrics',
      child: Column(
        children: const [
          const ClinicalDirectorQualityMetricsHeaderSection(),
          const ClinicalDirectorQualityMetricsFilterBarSection(),
          const ClinicalDirectorQualityMetricsMetricsSummarySection(),
          const ClinicalDirectorQualityMetricsChartAreaSection(),
          const ClinicalDirectorQualityMetricsExportActionsSection(),
        ],
      ),
    );
  }
}
