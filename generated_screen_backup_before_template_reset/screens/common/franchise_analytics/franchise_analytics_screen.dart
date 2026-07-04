import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_analytics_header_section.dart';
import 'sections/franchise_analytics_filter_bar_section.dart';
import 'sections/franchise_analytics_metrics_summary_section.dart';
import 'sections/franchise_analytics_chart_area_section.dart';
import 'sections/franchise_analytics_export_actions_section.dart';

class FranchiseAnalyticsScreen extends StatelessWidget {
  const FranchiseAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_analytics',
      title: 'FranchiseAnalyticsScreen',
      child: Column(
        children: const [
          const FranchiseAnalyticsHeaderSection(),
          const FranchiseAnalyticsFilterBarSection(),
          const FranchiseAnalyticsMetricsSummarySection(),
          const FranchiseAnalyticsChartAreaSection(),
          const FranchiseAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
