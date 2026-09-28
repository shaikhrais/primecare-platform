import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/admin_reports_header_section.dart';
import 'sections/admin_reports_filter_bar_section.dart';
import 'sections/admin_reports_metrics_summary_section.dart';
import 'sections/admin_reports_chart_area_section.dart';
import 'sections/admin_reports_export_actions_section.dart';

class AdminReportsScreen extends StatelessWidget {
  const AdminReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'admin_reports',
      title: 'Admin Reports',
      child: Column(
        children: const [
          const AdminReportsHeaderSection(),
          const AdminReportsFilterBarSection(),
          const AdminReportsMetricsSummarySection(),
          const AdminReportsChartAreaSection(),
          const AdminReportsExportActionsSection(),
        ],
      ),
    );
  }
}
