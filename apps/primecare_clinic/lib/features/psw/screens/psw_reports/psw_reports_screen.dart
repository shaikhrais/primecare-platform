import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_reports_header_section.dart';
import 'sections/psw_reports_filter_bar_section.dart';
import 'sections/psw_reports_metrics_summary_section.dart';
import 'sections/psw_reports_chart_area_section.dart';
import 'sections/psw_reports_export_actions_section.dart';

class PswReportsScreen extends StatelessWidget {
  const PswReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_reports',
      title: 'Psw Reports',
      child: Column(
        children: const [
          const PswReportsHeaderSection(),
          const PswReportsFilterBarSection(),
          const PswReportsMetricsSummarySection(),
          const PswReportsChartAreaSection(),
          const PswReportsExportActionsSection(),
        ],
      ),
    );
  }
}
