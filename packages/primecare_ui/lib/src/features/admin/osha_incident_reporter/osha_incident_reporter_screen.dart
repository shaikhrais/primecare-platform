import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/osha_incident_reporter_header_section.dart';
import 'sections/osha_incident_reporter_filter_bar_section.dart';
import 'sections/osha_incident_reporter_metrics_summary_section.dart';
import 'sections/osha_incident_reporter_chart_area_section.dart';
import 'sections/osha_incident_reporter_export_actions_section.dart';

class OshaIncidentReporterScreen extends StatelessWidget {
  const OshaIncidentReporterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'osha_incident_reporter',
      title: 'Osha Incident Reporter',
      child: Column(
        children: const [
          const OshaIncidentReporterHeaderSection(),
          const OshaIncidentReporterFilterBarSection(),
          const OshaIncidentReporterMetricsSummarySection(),
          const OshaIncidentReporterChartAreaSection(),
          const OshaIncidentReporterExportActionsSection(),
        ],
      ),
    );
  }
}
