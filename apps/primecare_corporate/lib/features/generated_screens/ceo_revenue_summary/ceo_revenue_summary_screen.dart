import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/ceo_revenue_summary_header_section.dart';
import 'sections/ceo_revenue_summary_filter_bar_section.dart';
import 'sections/ceo_revenue_summary_metrics_summary_section.dart';
import 'sections/ceo_revenue_summary_chart_area_section.dart';
import 'sections/ceo_revenue_summary_export_actions_section.dart';

class CeoRevenueSummaryScreen extends StatelessWidget {
  const CeoRevenueSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'ceo_revenue_summary',
      title: 'Ceo Revenue Summary',
      child: Column(
        children: const [
          const CeoRevenueSummaryHeaderSection(),
          const CeoRevenueSummaryFilterBarSection(),
          const CeoRevenueSummaryMetricsSummarySection(),
          const CeoRevenueSummaryChartAreaSection(),
          const CeoRevenueSummaryExportActionsSection(),
        ],
      ),
    );
  }
}
