import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_incident_report_header_section.dart';
import 'sections/psw_incident_report_filter_bar_section.dart';
import 'sections/psw_incident_report_metrics_summary_section.dart';
import 'sections/psw_incident_report_chart_area_section.dart';
import 'sections/psw_incident_report_export_actions_section.dart';

class PswIncidentReportScreen extends StatelessWidget {
  const PswIncidentReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_incident_report',
      title: 'Report Incident',
      child: Column(
        children: const [
          const PswIncidentReportHeaderSection(),
          const PswIncidentReportFilterBarSection(),
          const PswIncidentReportMetricsSummarySection(),
          const PswIncidentReportChartAreaSection(),
          const PswIncidentReportExportActionsSection(),
        ],
      ),
    );
  }
}
