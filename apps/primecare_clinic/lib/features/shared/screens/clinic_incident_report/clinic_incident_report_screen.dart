import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinic_incident_report_header_section.dart';
import 'sections/clinic_incident_report_filter_bar_section.dart';
import 'sections/clinic_incident_report_metrics_summary_section.dart';
import 'sections/clinic_incident_report_chart_area_section.dart';
import 'sections/clinic_incident_report_export_actions_section.dart';

class ClinicIncidentReportScreen extends StatelessWidget {
  const ClinicIncidentReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinic_incident_report',
      title: 'Clinic Incident Report',
      child: Column(
        children: const [
          const ClinicIncidentReportHeaderSection(),
          const ClinicIncidentReportFilterBarSection(),
          const ClinicIncidentReportMetricsSummarySection(),
          const ClinicIncidentReportChartAreaSection(),
          const ClinicIncidentReportExportActionsSection(),
        ],
      ),
    );
  }
}
