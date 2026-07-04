import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/compliance_manager_analytics_header_section.dart';
import 'sections/compliance_manager_analytics_filter_bar_section.dart';
import 'sections/compliance_manager_analytics_metrics_summary_section.dart';
import 'sections/compliance_manager_analytics_chart_area_section.dart';
import 'sections/compliance_manager_analytics_export_actions_section.dart';

class ComplianceManagerAnalyticsScreen extends StatelessWidget {
  const ComplianceManagerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'compliance_manager_analytics',
      title: 'ComplianceManagerAnalyticsScreen',
      child: Column(
        children: const [
          const ComplianceManagerAnalyticsHeaderSection(),
          const ComplianceManagerAnalyticsFilterBarSection(),
          const ComplianceManagerAnalyticsMetricsSummarySection(),
          const ComplianceManagerAnalyticsChartAreaSection(),
          const ComplianceManagerAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
