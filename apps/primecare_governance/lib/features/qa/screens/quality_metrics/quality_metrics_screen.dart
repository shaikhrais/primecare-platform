import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/quality_metrics_header_section.dart';
import 'sections/quality_metrics_filter_bar_section.dart';
import 'sections/quality_metrics_metrics_summary_section.dart';
import 'sections/quality_metrics_chart_area_section.dart';
import 'sections/quality_metrics_export_actions_section.dart';

class QualityMetricsScreen extends StatelessWidget {
  const QualityMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'quality_metrics',
      title: 'Quality Metrics',
      child: Column(
        children: const [
          const QualityMetricsHeaderSection(),
          const QualityMetricsFilterBarSection(),
          const QualityMetricsMetricsSummarySection(),
          const QualityMetricsChartAreaSection(),
          const QualityMetricsExportActionsSection(),
        ],
      ),
    );
  }
}
