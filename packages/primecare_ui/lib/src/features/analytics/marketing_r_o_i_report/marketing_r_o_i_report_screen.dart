import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/marketing_r_o_i_report_header_section.dart';
import 'sections/marketing_r_o_i_report_filter_bar_section.dart';
import 'sections/marketing_r_o_i_report_metrics_summary_section.dart';
import 'sections/marketing_r_o_i_report_chart_area_section.dart';
import 'sections/marketing_r_o_i_report_export_actions_section.dart';

class MarketingROIReportScreen extends StatelessWidget {
  const MarketingROIReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'marketing_r_o_i_report',
      title: 'Marketing R O I Report',
      child: Column(
        children: const [
          const MarketingROIReportHeaderSection(),
          const MarketingROIReportFilterBarSection(),
          const MarketingROIReportMetricsSummarySection(),
          const MarketingROIReportChartAreaSection(),
          const MarketingROIReportExportActionsSection(),
        ],
      ),
    );
  }
}
