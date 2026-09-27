import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/incident_reports_header_section.dart';
import 'sections/incident_reports_filter_bar_section.dart';
import 'sections/incident_reports_metrics_summary_section.dart';
import 'sections/incident_reports_chart_area_section.dart';
import 'sections/incident_reports_export_actions_section.dart';

class IncidentReportsScreen extends StatelessWidget {
  const IncidentReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'incident_reports',
      title: 'Incident Reports',
      child: Column(
        children: const [
          const IncidentReportsHeaderSection(),
          const IncidentReportsFilterBarSection(),
          const IncidentReportsMetricsSummarySection(),
          const IncidentReportsChartAreaSection(),
          const IncidentReportsExportActionsSection(),
        ],
      ),
    );
  }
}
