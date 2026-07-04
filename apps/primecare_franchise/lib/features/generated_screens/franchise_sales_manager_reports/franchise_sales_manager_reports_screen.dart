import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_sales_manager_reports_header_section.dart';
import 'sections/franchise_sales_manager_reports_filter_bar_section.dart';
import 'sections/franchise_sales_manager_reports_metrics_summary_section.dart';
import 'sections/franchise_sales_manager_reports_chart_area_section.dart';
import 'sections/franchise_sales_manager_reports_export_actions_section.dart';

class FranchiseSalesManagerReportsScreen extends StatelessWidget {
  const FranchiseSalesManagerReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_sales_manager_reports',
      title: 'Franchise Sales Manager Reports',
      child: Column(
        children: const [
          const FranchiseSalesManagerReportsHeaderSection(),
          const FranchiseSalesManagerReportsFilterBarSection(),
          const FranchiseSalesManagerReportsMetricsSummarySection(),
          const FranchiseSalesManagerReportsChartAreaSection(),
          const FranchiseSalesManagerReportsExportActionsSection(),
        ],
      ),
    );
  }
}
