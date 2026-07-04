import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rpn_reports_header_section.dart';
import 'sections/rpn_reports_filter_bar_section.dart';
import 'sections/rpn_reports_metrics_summary_section.dart';
import 'sections/rpn_reports_chart_area_section.dart';
import 'sections/rpn_reports_export_actions_section.dart';

class RpnReportsScreen extends StatelessWidget {
  const RpnReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rpn_reports',
      title: 'RpnReportsScreen',
      child: Column(
        children: const [
          const RpnReportsHeaderSection(),
          const RpnReportsFilterBarSection(),
          const RpnReportsMetricsSummarySection(),
          const RpnReportsChartAreaSection(),
          const RpnReportsExportActionsSection(),
        ],
      ),
    );
  }
}
