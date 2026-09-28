import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/leadership_reports_header_section.dart';
import 'sections/leadership_reports_filter_bar_section.dart';
import 'sections/leadership_reports_metrics_summary_section.dart';
import 'sections/leadership_reports_chart_area_section.dart';
import 'sections/leadership_reports_export_actions_section.dart';

class LeadershipReportsScreen extends StatelessWidget {
  const LeadershipReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'leadership_reports',
      title: 'Leadership Reports',
      child: Column(
        children: const [
          const LeadershipReportsHeaderSection(),
          const LeadershipReportsFilterBarSection(),
          const LeadershipReportsMetricsSummarySection(),
          const LeadershipReportsChartAreaSection(),
          const LeadershipReportsExportActionsSection(),
        ],
      ),
    );
  }
}
