import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/regional_bdm_reports_header_section.dart';
import 'sections/regional_bdm_reports_filter_bar_section.dart';
import 'sections/regional_bdm_reports_metrics_summary_section.dart';
import 'sections/regional_bdm_reports_chart_area_section.dart';
import 'sections/regional_bdm_reports_export_actions_section.dart';

class RegionalBdmReportsScreen extends StatelessWidget {
  const RegionalBdmReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'regional_bdm_reports',
      title: 'Regional Bdm Reports',
      child: Column(
        children: const [
          const RegionalBdmReportsHeaderSection(),
          const RegionalBdmReportsFilterBarSection(),
          const RegionalBdmReportsMetricsSummarySection(),
          const RegionalBdmReportsChartAreaSection(),
          const RegionalBdmReportsExportActionsSection(),
        ],
      ),
    );
  }
}
