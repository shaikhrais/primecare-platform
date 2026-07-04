import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cto_reports_header_section.dart';
import 'sections/cto_reports_filter_bar_section.dart';
import 'sections/cto_reports_metrics_summary_section.dart';
import 'sections/cto_reports_chart_area_section.dart';
import 'sections/cto_reports_export_actions_section.dart';

class CtoReportsScreen extends StatelessWidget {
  const CtoReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cto_reports',
      title: 'Cto Reports',
      child: Column(
        children: const [
          const CtoReportsHeaderSection(),
          const CtoReportsFilterBarSection(),
          const CtoReportsMetricsSummarySection(),
          const CtoReportsChartAreaSection(),
          const CtoReportsExportActionsSection(),
        ],
      ),
    );
  }
}
