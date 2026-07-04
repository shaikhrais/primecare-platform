import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/governance_officer_analytics_header_section.dart';
import 'sections/governance_officer_analytics_filter_bar_section.dart';
import 'sections/governance_officer_analytics_metrics_summary_section.dart';
import 'sections/governance_officer_analytics_chart_area_section.dart';
import 'sections/governance_officer_analytics_export_actions_section.dart';

class GovernanceOfficerAnalyticsScreen extends StatelessWidget {
  const GovernanceOfficerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'governance_officer_analytics',
      title: 'GovernanceOfficerAnalyticsScreen',
      child: Column(
        children: const [
          const GovernanceOfficerAnalyticsHeaderSection(),
          const GovernanceOfficerAnalyticsFilterBarSection(),
          const GovernanceOfficerAnalyticsMetricsSummarySection(),
          const GovernanceOfficerAnalyticsChartAreaSection(),
          const GovernanceOfficerAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
