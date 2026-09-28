import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/ceo_leadership_reports_header_section.dart';
import 'sections/ceo_leadership_reports_filter_bar_section.dart';
import 'sections/ceo_leadership_reports_metrics_summary_section.dart';
import 'sections/ceo_leadership_reports_chart_area_section.dart';
import 'sections/ceo_leadership_reports_export_actions_section.dart';

class CeoLeadershipReportsScreen extends StatelessWidget {
  const CeoLeadershipReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'ceo_leadership_reports',
      title: 'Ceo Leadership Reports',
      child: Column(
        children: const [
          const CeoLeadershipReportsHeaderSection(),
          const CeoLeadershipReportsFilterBarSection(),
          const CeoLeadershipReportsMetricsSummarySection(),
          const CeoLeadershipReportsChartAreaSection(),
          const CeoLeadershipReportsExportActionsSection(),
        ],
      ),
    );
  }
}
