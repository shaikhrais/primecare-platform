import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_analytics_header_section.dart';
import 'sections/patient_analytics_filter_bar_section.dart';
import 'sections/patient_analytics_metrics_summary_section.dart';
import 'sections/patient_analytics_chart_area_section.dart';
import 'sections/patient_analytics_export_actions_section.dart';

class PatientAnalyticsScreen extends StatelessWidget {
  const PatientAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_analytics',
      title: 'PatientAnalyticsScreen',
      child: Column(
        children: const [
          const PatientAnalyticsHeaderSection(),
          const PatientAnalyticsFilterBarSection(),
          const PatientAnalyticsMetricsSummarySection(),
          const PatientAnalyticsChartAreaSection(),
          const PatientAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
