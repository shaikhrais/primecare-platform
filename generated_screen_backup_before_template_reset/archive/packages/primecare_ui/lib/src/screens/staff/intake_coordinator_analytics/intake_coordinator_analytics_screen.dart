import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/intake_coordinator_analytics_header_section.dart';
import 'sections/intake_coordinator_analytics_filter_bar_section.dart';
import 'sections/intake_coordinator_analytics_metrics_summary_section.dart';
import 'sections/intake_coordinator_analytics_chart_area_section.dart';
import 'sections/intake_coordinator_analytics_export_actions_section.dart';

class IntakeCoordinatorAnalyticsScreen extends StatelessWidget {
  const IntakeCoordinatorAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'intake_coordinator_analytics',
      title: 'IntakeCoordinatorAnalyticsScreen',
      child: Column(
        children: const [
          const IntakeCoordinatorAnalyticsHeaderSection(),
          const IntakeCoordinatorAnalyticsFilterBarSection(),
          const IntakeCoordinatorAnalyticsMetricsSummarySection(),
          const IntakeCoordinatorAnalyticsChartAreaSection(),
          const IntakeCoordinatorAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
