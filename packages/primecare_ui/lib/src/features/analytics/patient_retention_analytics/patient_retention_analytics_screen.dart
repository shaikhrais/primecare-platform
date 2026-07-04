import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_retention_analytics_header_section.dart';
import 'sections/patient_retention_analytics_filter_bar_section.dart';
import 'sections/patient_retention_analytics_metrics_summary_section.dart';
import 'sections/patient_retention_analytics_chart_area_section.dart';
import 'sections/patient_retention_analytics_export_actions_section.dart';

class PatientRetentionAnalyticsScreen extends StatelessWidget {
  const PatientRetentionAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_retention_analytics',
      title: 'Patient Retention Analytics',
      child: Column(
        children: const [
          const PatientRetentionAnalyticsHeaderSection(),
          const PatientRetentionAnalyticsFilterBarSection(),
          const PatientRetentionAnalyticsMetricsSummarySection(),
          const PatientRetentionAnalyticsChartAreaSection(),
          const PatientRetentionAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
