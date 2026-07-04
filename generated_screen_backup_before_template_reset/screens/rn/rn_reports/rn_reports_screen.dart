import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rn_reports_header_section.dart';
import 'sections/rn_reports_filter_bar_section.dart';
import 'sections/rn_reports_metrics_summary_section.dart';
import 'sections/rn_reports_chart_area_section.dart';
import 'sections/rn_reports_export_actions_section.dart';

class RnReportsScreen extends StatelessWidget {
  const RnReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rn_reports',
      title: 'RnReportsScreen',
      child: Column(
        children: const [
          const RnReportsHeaderSection(),
          const RnReportsFilterBarSection(),
          const RnReportsMetricsSummarySection(),
          const RnReportsChartAreaSection(),
          const RnReportsExportActionsSection(),
        ],
      ),
    );
  }
}
