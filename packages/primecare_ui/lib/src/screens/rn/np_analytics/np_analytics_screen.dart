import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/np_analytics_header_section.dart';
import 'sections/np_analytics_filter_bar_section.dart';
import 'sections/np_analytics_metrics_summary_section.dart';
import 'sections/np_analytics_chart_area_section.dart';
import 'sections/np_analytics_export_actions_section.dart';

class NpAnalyticsScreen extends StatelessWidget {
  const NpAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'np_analytics',
      title: 'Nurse Practitioner (NP) Analytics',
      child: Column(
        children: const [
          const NpAnalyticsHeaderSection(),
          const NpAnalyticsFilterBarSection(),
          const NpAnalyticsMetricsSummarySection(),
          const NpAnalyticsChartAreaSection(),
          const NpAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}

typedef NursePractitionerNPAnalyticsScreen = NpAnalyticsScreen;
