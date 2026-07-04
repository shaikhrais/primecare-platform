import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rmt_reports_header_section.dart';
import 'sections/rmt_reports_filter_bar_section.dart';
import 'sections/rmt_reports_metrics_summary_section.dart';
import 'sections/rmt_reports_chart_area_section.dart';
import 'sections/rmt_reports_export_actions_section.dart';

class RmtReportsScreen extends StatelessWidget {
  const RmtReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rmt_reports',
      title: 'RmtReportsScreen',
      child: Column(
        children: const [
          const RmtReportsHeaderSection(),
          const RmtReportsFilterBarSection(),
          const RmtReportsMetricsSummarySection(),
          const RmtReportsChartAreaSection(),
          const RmtReportsExportActionsSection(),
        ],
      ),
    );
  }
}
