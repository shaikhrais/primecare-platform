import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/telehealth_quality_metrics_header_section.dart';
import 'sections/telehealth_quality_metrics_filter_bar_section.dart';
import 'sections/telehealth_quality_metrics_metrics_summary_section.dart';
import 'sections/telehealth_quality_metrics_chart_area_section.dart';
import 'sections/telehealth_quality_metrics_export_actions_section.dart';

class TelehealthQualityMetricsScreen extends StatelessWidget {
  const TelehealthQualityMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'telehealth_quality_metrics',
      title: 'Telehealth Quality Metrics',
      child: Column(
        children: const [
          const TelehealthQualityMetricsHeaderSection(),
          const TelehealthQualityMetricsFilterBarSection(),
          const TelehealthQualityMetricsMetricsSummarySection(),
          const TelehealthQualityMetricsChartAreaSection(),
          const TelehealthQualityMetricsExportActionsSection(),
        ],
      ),
    );
  }
}
