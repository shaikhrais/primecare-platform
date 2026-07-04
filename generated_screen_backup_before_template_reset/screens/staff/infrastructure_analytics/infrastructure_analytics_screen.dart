import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/infrastructure_analytics_header_section.dart';
import 'sections/infrastructure_analytics_filter_bar_section.dart';
import 'sections/infrastructure_analytics_metrics_summary_section.dart';
import 'sections/infrastructure_analytics_chart_area_section.dart';
import 'sections/infrastructure_analytics_export_actions_section.dart';

class InfrastructureAnalyticsScreen extends StatelessWidget {
  const InfrastructureAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'infrastructure_analytics',
      title: 'InfrastructureAnalyticsScreen',
      child: Column(
        children: const [
          const InfrastructureAnalyticsHeaderSection(),
          const InfrastructureAnalyticsFilterBarSection(),
          const InfrastructureAnalyticsMetricsSummarySection(),
          const InfrastructureAnalyticsChartAreaSection(),
          const InfrastructureAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
