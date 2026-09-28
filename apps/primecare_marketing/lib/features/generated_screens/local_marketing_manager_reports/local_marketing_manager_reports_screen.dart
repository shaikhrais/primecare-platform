import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/local_marketing_manager_reports_header_section.dart';
import 'sections/local_marketing_manager_reports_filter_bar_section.dart';
import 'sections/local_marketing_manager_reports_metrics_summary_section.dart';
import 'sections/local_marketing_manager_reports_chart_area_section.dart';
import 'sections/local_marketing_manager_reports_export_actions_section.dart';

class LocalMarketingManagerReportsScreen extends StatelessWidget {
  const LocalMarketingManagerReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'local_marketing_manager_reports',
      title: 'Local Marketing Manager Reports',
      child: Column(
        children: const [
          const LocalMarketingManagerReportsHeaderSection(),
          const LocalMarketingManagerReportsFilterBarSection(),
          const LocalMarketingManagerReportsMetricsSummarySection(),
          const LocalMarketingManagerReportsChartAreaSection(),
          const LocalMarketingManagerReportsExportActionsSection(),
        ],
      ),
    );
  }
}
