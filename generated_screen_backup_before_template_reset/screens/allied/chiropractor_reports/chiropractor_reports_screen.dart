import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/chiropractor_reports_header_section.dart';
import 'sections/chiropractor_reports_filter_bar_section.dart';
import 'sections/chiropractor_reports_metrics_summary_section.dart';
import 'sections/chiropractor_reports_chart_area_section.dart';
import 'sections/chiropractor_reports_export_actions_section.dart';

class ChiropractorReportsScreen extends StatelessWidget {
  const ChiropractorReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'chiropractor_reports',
      title: 'ChiropractorReportsScreen',
      child: Column(
        children: const [
          const ChiropractorReportsHeaderSection(),
          const ChiropractorReportsFilterBarSection(),
          const ChiropractorReportsMetricsSummarySection(),
          const ChiropractorReportsChartAreaSection(),
          const ChiropractorReportsExportActionsSection(),
        ],
      ),
    );
  }
}
