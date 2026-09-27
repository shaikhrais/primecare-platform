import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/quality_assurance_analytics_header_section.dart';
import 'sections/quality_assurance_analytics_filter_bar_section.dart';
import 'sections/quality_assurance_analytics_metrics_summary_section.dart';
import 'sections/quality_assurance_analytics_chart_area_section.dart';
import 'sections/quality_assurance_analytics_export_actions_section.dart';

class QualityAssuranceAnalyticsScreen extends StatelessWidget {
  const QualityAssuranceAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'quality_assurance_analytics',
      title: 'QualityAssuranceAnalyticsScreen',
      child: Column(
        children: const [
          const QualityAssuranceAnalyticsHeaderSection(),
          const QualityAssuranceAnalyticsFilterBarSection(),
          const QualityAssuranceAnalyticsMetricsSummarySection(),
          const QualityAssuranceAnalyticsChartAreaSection(),
          const QualityAssuranceAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
