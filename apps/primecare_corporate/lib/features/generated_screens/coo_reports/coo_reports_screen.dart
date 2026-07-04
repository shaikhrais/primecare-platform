import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/coo_reports_header_section.dart';
import 'sections/coo_reports_filter_bar_section.dart';
import 'sections/coo_reports_metrics_summary_section.dart';
import 'sections/coo_reports_chart_area_section.dart';
import 'sections/coo_reports_export_actions_section.dart';

class CooReportsScreen extends StatelessWidget {
  const CooReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'coo_reports',
      title: 'Coo Reports',
      child: Column(
        children: const [
          const CooReportsHeaderSection(),
          const CooReportsFilterBarSection(),
          const CooReportsMetricsSummarySection(),
          const CooReportsChartAreaSection(),
          const CooReportsExportActionsSection(),
        ],
      ),
    );
  }
}
