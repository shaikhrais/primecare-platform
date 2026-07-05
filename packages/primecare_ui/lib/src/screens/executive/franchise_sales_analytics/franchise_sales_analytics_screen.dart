import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_sales_analytics_header_section.dart';
import 'sections/franchise_sales_analytics_filter_bar_section.dart';
import 'sections/franchise_sales_analytics_metrics_summary_section.dart';
import 'sections/franchise_sales_analytics_chart_area_section.dart';
import 'sections/franchise_sales_analytics_export_actions_section.dart';

class FranchiseSalesAnalyticsScreen extends StatelessWidget {
  const FranchiseSalesAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_sales_analytics',
      title: 'Franchise Sales Manager Analytics',
      child: Column(
        children: const [
          const FranchiseSalesAnalyticsHeaderSection(),
          const FranchiseSalesAnalyticsFilterBarSection(),
          const FranchiseSalesAnalyticsMetricsSummarySection(),
          const FranchiseSalesAnalyticsChartAreaSection(),
          const FranchiseSalesAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}

typedef FranchiseSalesManagerAnalyticsScreen = FranchiseSalesAnalyticsScreen;
