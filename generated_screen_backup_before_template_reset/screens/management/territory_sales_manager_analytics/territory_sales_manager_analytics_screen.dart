import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_sales_manager_analytics_header_section.dart';
import 'sections/territory_sales_manager_analytics_filter_bar_section.dart';
import 'sections/territory_sales_manager_analytics_metrics_summary_section.dart';
import 'sections/territory_sales_manager_analytics_chart_area_section.dart';
import 'sections/territory_sales_manager_analytics_export_actions_section.dart';

class TerritorySalesManagerAnalyticsScreen extends StatelessWidget {
  const TerritorySalesManagerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_sales_manager_analytics',
      title: 'TerritorySalesManagerAnalyticsScreen',
      child: Column(
        children: const [
          const TerritorySalesManagerAnalyticsHeaderSection(),
          const TerritorySalesManagerAnalyticsFilterBarSection(),
          const TerritorySalesManagerAnalyticsMetricsSummarySection(),
          const TerritorySalesManagerAnalyticsChartAreaSection(),
          const TerritorySalesManagerAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
