import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/quality_assurance_metrics_header_section.dart';
import 'sections/quality_assurance_metrics_filter_bar_section.dart';
import 'sections/quality_assurance_metrics_metrics_summary_section.dart';
import 'sections/quality_assurance_metrics_chart_area_section.dart';
import 'sections/quality_assurance_metrics_export_actions_section.dart';

class QualityAssuranceMetricsScreen extends StatelessWidget {
  const QualityAssuranceMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'quality_assurance_metrics',
      title: 'Quality Assurance Metrics',
      child: Column(
        children: const [
          const QualityAssuranceMetricsHeaderSection(),
          const QualityAssuranceMetricsFilterBarSection(),
          const QualityAssuranceMetricsMetricsSummarySection(),
          const QualityAssuranceMetricsChartAreaSection(),
          const QualityAssuranceMetricsExportActionsSection(),
        ],
      ),
    );
  }
}
