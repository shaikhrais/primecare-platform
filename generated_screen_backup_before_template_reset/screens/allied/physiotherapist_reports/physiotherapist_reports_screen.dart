import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/physiotherapist_reports_header_section.dart';
import 'sections/physiotherapist_reports_filter_bar_section.dart';
import 'sections/physiotherapist_reports_metrics_summary_section.dart';
import 'sections/physiotherapist_reports_chart_area_section.dart';
import 'sections/physiotherapist_reports_export_actions_section.dart';

class PhysiotherapistReportsScreen extends StatelessWidget {
  const PhysiotherapistReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'physiotherapist_reports',
      title: 'PhysiotherapistReportsScreen',
      child: Column(
        children: const [
          const PhysiotherapistReportsHeaderSection(),
          const PhysiotherapistReportsFilterBarSection(),
          const PhysiotherapistReportsMetricsSummarySection(),
          const PhysiotherapistReportsChartAreaSection(),
          const PhysiotherapistReportsExportActionsSection(),
        ],
      ),
    );
  }
}
