import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinic_analytics_header_section.dart';
import 'sections/clinic_analytics_filter_bar_section.dart';
import 'sections/clinic_analytics_metrics_summary_section.dart';
import 'sections/clinic_analytics_chart_area_section.dart';
import 'sections/clinic_analytics_export_actions_section.dart';

class ClinicAnalyticsScreen extends StatelessWidget {
  const ClinicAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinic_analytics',
      title: 'ClinicAnalyticsScreen',
      child: Column(
        children: const [
          const ClinicAnalyticsHeaderSection(),
          const ClinicAnalyticsFilterBarSection(),
          const ClinicAnalyticsMetricsSummarySection(),
          const ClinicAnalyticsChartAreaSection(),
          const ClinicAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
