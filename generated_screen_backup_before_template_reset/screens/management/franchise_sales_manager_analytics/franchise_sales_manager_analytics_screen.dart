import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_sales_manager_analytics_header_section.dart';
import 'sections/franchise_sales_manager_analytics_filter_bar_section.dart';
import 'sections/franchise_sales_manager_analytics_metrics_summary_section.dart';
import 'sections/franchise_sales_manager_analytics_chart_area_section.dart';
import 'sections/franchise_sales_manager_analytics_export_actions_section.dart';

class FranchiseSalesManagerAnalyticsScreen extends StatelessWidget {
  const FranchiseSalesManagerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_sales_manager_analytics',
      title: 'FranchiseSalesManagerAnalyticsScreen',
      child: Column(
        children: const [
          const FranchiseSalesManagerAnalyticsHeaderSection(),
          const FranchiseSalesManagerAnalyticsFilterBarSection(),
          const FranchiseSalesManagerAnalyticsMetricsSummarySection(),
          const FranchiseSalesManagerAnalyticsChartAreaSection(),
          const FranchiseSalesManagerAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
