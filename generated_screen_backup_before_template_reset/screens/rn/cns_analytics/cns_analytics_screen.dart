import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cns_analytics_header_section.dart';
import 'sections/cns_analytics_filter_bar_section.dart';
import 'sections/cns_analytics_metrics_summary_section.dart';
import 'sections/cns_analytics_chart_area_section.dart';
import 'sections/cns_analytics_export_actions_section.dart';

class CnsAnalyticsScreen extends StatelessWidget {
  const CnsAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cns_analytics',
      title: 'Clinical Nurse Specialist Analytics',
      child: Column(
        children: const [
          const CnsAnalyticsHeaderSection(),
          const CnsAnalyticsFilterBarSection(),
          const CnsAnalyticsMetricsSummarySection(),
          const CnsAnalyticsChartAreaSection(),
          const CnsAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
