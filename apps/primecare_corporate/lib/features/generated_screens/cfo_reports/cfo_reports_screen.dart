import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cfo_reports_header_section.dart';
import 'sections/cfo_reports_filter_bar_section.dart';
import 'sections/cfo_reports_metrics_summary_section.dart';
import 'sections/cfo_reports_chart_area_section.dart';
import 'sections/cfo_reports_export_actions_section.dart';

class CfoReportsScreen extends StatelessWidget {
  const CfoReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cfo_reports',
      title: 'Cfo Reports',
      child: Column(
        children: const [
          const CfoReportsHeaderSection(),
          const CfoReportsFilterBarSection(),
          const CfoReportsMetricsSummarySection(),
          const CfoReportsChartAreaSection(),
          const CfoReportsExportActionsSection(),
        ],
      ),
    );
  }
}
