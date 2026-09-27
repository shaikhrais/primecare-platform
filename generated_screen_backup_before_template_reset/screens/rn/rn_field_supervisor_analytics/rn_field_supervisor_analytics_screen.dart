import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rn_field_supervisor_analytics_header_section.dart';
import 'sections/rn_field_supervisor_analytics_filter_bar_section.dart';
import 'sections/rn_field_supervisor_analytics_metrics_summary_section.dart';
import 'sections/rn_field_supervisor_analytics_chart_area_section.dart';
import 'sections/rn_field_supervisor_analytics_export_actions_section.dart';

class RnFieldSupervisorAnalyticsScreen extends StatelessWidget {
  const RnFieldSupervisorAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rn_field_supervisor_analytics',
      title: 'Registered Nurse (RN) Field Supervisor Analytics',
      child: Column(
        children: const [
          const RnFieldSupervisorAnalyticsHeaderSection(),
          const RnFieldSupervisorAnalyticsFilterBarSection(),
          const RnFieldSupervisorAnalyticsMetricsSummarySection(),
          const RnFieldSupervisorAnalyticsChartAreaSection(),
          const RnFieldSupervisorAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
