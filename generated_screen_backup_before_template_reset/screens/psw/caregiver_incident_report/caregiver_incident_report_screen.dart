import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/caregiver_incident_report_header_section.dart';
import 'sections/caregiver_incident_report_filter_bar_section.dart';
import 'sections/caregiver_incident_report_metrics_summary_section.dart';
import 'sections/caregiver_incident_report_chart_area_section.dart';
import 'sections/caregiver_incident_report_export_actions_section.dart';

class CaregiverIncidentReportScreen extends StatelessWidget {
  const CaregiverIncidentReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'caregiver_incident_report',
      title: 'CaregiverIncidentReportScreen',
      child: Column(
        children: const [
          const CaregiverIncidentReportHeaderSection(),
          const CaregiverIncidentReportFilterBarSection(),
          const CaregiverIncidentReportMetricsSummarySection(),
          const CaregiverIncidentReportChartAreaSection(),
          const CaregiverIncidentReportExportActionsSection(),
        ],
      ),
    );
  }
}
