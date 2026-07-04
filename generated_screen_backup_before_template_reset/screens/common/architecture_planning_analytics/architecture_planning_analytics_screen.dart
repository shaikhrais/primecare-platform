import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/architecture_planning_analytics_header_section.dart';
import 'sections/architecture_planning_analytics_filter_bar_section.dart';
import 'sections/architecture_planning_analytics_metrics_summary_section.dart';
import 'sections/architecture_planning_analytics_chart_area_section.dart';
import 'sections/architecture_planning_analytics_export_actions_section.dart';

class ArchitecturePlanningAnalyticsScreen extends StatelessWidget {
  const ArchitecturePlanningAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'architecture_planning_analytics',
      title: 'ArchitecturePlanningAnalyticsScreen',
      child: Column(
        children: const [
          const ArchitecturePlanningAnalyticsHeaderSection(),
          const ArchitecturePlanningAnalyticsFilterBarSection(),
          const ArchitecturePlanningAnalyticsMetricsSummarySection(),
          const ArchitecturePlanningAnalyticsChartAreaSection(),
          const ArchitecturePlanningAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
