import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_sales_manager_reports_header_section.dart';
import 'sections/territory_sales_manager_reports_filter_bar_section.dart';
import 'sections/territory_sales_manager_reports_metrics_summary_section.dart';
import 'sections/territory_sales_manager_reports_chart_area_section.dart';
import 'sections/territory_sales_manager_reports_export_actions_section.dart';

class TerritorySalesManagerReportsScreen extends StatelessWidget {
  const TerritorySalesManagerReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_sales_manager_reports',
      title: 'Territory Sales Manager Reports',
      child: Column(
        children: const [
          const TerritorySalesManagerReportsHeaderSection(),
          const TerritorySalesManagerReportsFilterBarSection(),
          const TerritorySalesManagerReportsMetricsSummarySection(),
          const TerritorySalesManagerReportsChartAreaSection(),
          const TerritorySalesManagerReportsExportActionsSection(),
        ],
      ),
    );
  }
}
