import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinical_analytics_header_section.dart';
import 'sections/clinical_analytics_filter_bar_section.dart';
import 'sections/clinical_analytics_metrics_summary_section.dart';
import 'sections/clinical_analytics_chart_area_section.dart';
import 'sections/clinical_analytics_export_actions_section.dart';

class ClinicalAnalyticsScreen extends StatelessWidget {
  const ClinicalAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinical_analytics',
      title: 'ClinicalAnalyticsScreen',
      child: Column(
        children: const [
          const ClinicalAnalyticsHeaderSection(),
          const ClinicalAnalyticsFilterBarSection(),
          const ClinicalAnalyticsMetricsSummarySection(),
          const ClinicalAnalyticsChartAreaSection(),
          const ClinicalAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
