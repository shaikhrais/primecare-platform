import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/shift_report_header_section.dart';
import 'sections/shift_report_filter_bar_section.dart';
import 'sections/shift_report_metrics_summary_section.dart';
import 'sections/shift_report_chart_area_section.dart';
import 'sections/shift_report_export_actions_section.dart';

class ShiftReportScreen extends StatelessWidget {
  const ShiftReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'shift_report',
      title: 'ShiftReportScreen',
      child: Column(
        children: const [
          const ShiftReportHeaderSection(),
          const ShiftReportFilterBarSection(),
          const ShiftReportMetricsSummarySection(),
          const ShiftReportChartAreaSection(),
          const ShiftReportExportActionsSection(),
        ],
      ),
    );
  }
}
