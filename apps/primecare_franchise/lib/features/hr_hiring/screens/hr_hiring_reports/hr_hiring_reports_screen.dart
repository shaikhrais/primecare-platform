import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_hiring_reports_header_section.dart';
import 'sections/hr_hiring_reports_filter_bar_section.dart';
import 'sections/hr_hiring_reports_metrics_summary_section.dart';
import 'sections/hr_hiring_reports_chart_area_section.dart';
import 'sections/hr_hiring_reports_export_actions_section.dart';

class HrHiringReportsScreen extends StatelessWidget {
  const HrHiringReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_hiring_reports',
      title: 'Hr Hiring Reports',
      child: Column(
        children: const [
          const HrHiringReportsHeaderSection(),
          const HrHiringReportsFilterBarSection(),
          const HrHiringReportsMetricsSummarySection(),
          const HrHiringReportsChartAreaSection(),
          const HrHiringReportsExportActionsSection(),
        ],
      ),
    );
  }
}
