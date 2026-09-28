import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/partnership_manager_reports_header_section.dart';
import 'sections/partnership_manager_reports_filter_bar_section.dart';
import 'sections/partnership_manager_reports_metrics_summary_section.dart';
import 'sections/partnership_manager_reports_chart_area_section.dart';
import 'sections/partnership_manager_reports_export_actions_section.dart';

class PartnershipManagerReportsScreen extends StatelessWidget {
  const PartnershipManagerReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'partnership_manager_reports',
      title: 'Partnership Manager Reports',
      child: Column(
        children: const [
          const PartnershipManagerReportsHeaderSection(),
          const PartnershipManagerReportsFilterBarSection(),
          const PartnershipManagerReportsMetricsSummarySection(),
          const PartnershipManagerReportsChartAreaSection(),
          const PartnershipManagerReportsExportActionsSection(),
        ],
      ),
    );
  }
}
