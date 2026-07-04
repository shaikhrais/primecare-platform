import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/therapist_analytics_header_section.dart';
import 'sections/therapist_analytics_filter_bar_section.dart';
import 'sections/therapist_analytics_metrics_summary_section.dart';
import 'sections/therapist_analytics_chart_area_section.dart';
import 'sections/therapist_analytics_export_actions_section.dart';

class TherapistAnalyticsScreen extends StatelessWidget {
  const TherapistAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'therapist_analytics',
      title: 'Therapist Analytics',
      child: Column(
        children: const [
          const TherapistAnalyticsHeaderSection(),
          const TherapistAnalyticsFilterBarSection(),
          const TherapistAnalyticsMetricsSummarySection(),
          const TherapistAnalyticsChartAreaSection(),
          const TherapistAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
