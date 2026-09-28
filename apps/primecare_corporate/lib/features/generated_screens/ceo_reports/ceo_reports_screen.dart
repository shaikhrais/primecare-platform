import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/ceo_reports_header_section.dart';
import 'sections/ceo_reports_filter_bar_section.dart';
import 'sections/ceo_reports_metrics_summary_section.dart';
import 'sections/ceo_reports_chart_area_section.dart';
import 'sections/ceo_reports_export_actions_section.dart';

class CeoReportsScreen extends StatelessWidget {
  const CeoReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'ceo_reports',
      title: 'Ceo Reports',
      child: Column(
        children: const [
          const CeoReportsHeaderSection(),
          const CeoReportsFilterBarSection(),
          const CeoReportsMetricsSummarySection(),
          const CeoReportsChartAreaSection(),
          const CeoReportsExportActionsSection(),
        ],
      ),
    );
  }
}
