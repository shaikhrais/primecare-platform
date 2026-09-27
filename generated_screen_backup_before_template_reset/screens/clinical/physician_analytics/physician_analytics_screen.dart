import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/physician_analytics_header_section.dart';
import 'sections/physician_analytics_filter_bar_section.dart';
import 'sections/physician_analytics_metrics_summary_section.dart';
import 'sections/physician_analytics_chart_area_section.dart';
import 'sections/physician_analytics_export_actions_section.dart';

class PhysicianAnalyticsScreen extends StatelessWidget {
  const PhysicianAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'physician_analytics',
      title: 'Physician Analytics',
      child: Column(
        children: const [
          const PhysicianAnalyticsHeaderSection(),
          const PhysicianAnalyticsFilterBarSection(),
          const PhysicianAnalyticsMetricsSummarySection(),
          const PhysicianAnalyticsChartAreaSection(),
          const PhysicianAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
