import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hsw_incident_reports_header_section.dart';
import 'sections/hsw_incident_reports_filter_bar_section.dart';
import 'sections/hsw_incident_reports_metrics_summary_section.dart';
import 'sections/hsw_incident_reports_chart_area_section.dart';
import 'sections/hsw_incident_reports_export_actions_section.dart';

class HswIncidentReportsScreen extends StatelessWidget {
  const HswIncidentReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hsw_incident_reports',
      title: 'HswIncidentReportsScreen',
      child: Column(
        children: const [
          const HswIncidentReportsHeaderSection(),
          const HswIncidentReportsFilterBarSection(),
          const HswIncidentReportsMetricsSummarySection(),
          const HswIncidentReportsChartAreaSection(),
          const HswIncidentReportsExportActionsSection(),
        ],
      ),
    );
  }
}
