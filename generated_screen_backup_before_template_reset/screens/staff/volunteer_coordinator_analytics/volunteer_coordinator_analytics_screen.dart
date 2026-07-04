import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/volunteer_coordinator_analytics_header_section.dart';
import 'sections/volunteer_coordinator_analytics_filter_bar_section.dart';
import 'sections/volunteer_coordinator_analytics_metrics_summary_section.dart';
import 'sections/volunteer_coordinator_analytics_chart_area_section.dart';
import 'sections/volunteer_coordinator_analytics_export_actions_section.dart';

class VolunteerCoordinatorAnalyticsScreen extends StatelessWidget {
  const VolunteerCoordinatorAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'volunteer_coordinator_analytics',
      title: 'VolunteerCoordinatorAnalyticsScreen',
      child: Column(
        children: const [
          const VolunteerCoordinatorAnalyticsHeaderSection(),
          const VolunteerCoordinatorAnalyticsFilterBarSection(),
          const VolunteerCoordinatorAnalyticsMetricsSummarySection(),
          const VolunteerCoordinatorAnalyticsChartAreaSection(),
          const VolunteerCoordinatorAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
