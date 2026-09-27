import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/adverse_event_reporting_portal_header_section.dart';
import 'sections/adverse_event_reporting_portal_filter_bar_section.dart';
import 'sections/adverse_event_reporting_portal_metrics_summary_section.dart';
import 'sections/adverse_event_reporting_portal_chart_area_section.dart';
import 'sections/adverse_event_reporting_portal_export_actions_section.dart';

class AdverseEventReportingPortalScreen extends StatelessWidget {
  const AdverseEventReportingPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'adverse_event_reporting_portal',
      title: 'Adverse Event Reporting Portal',
      child: Column(
        children: const [
          const AdverseEventReportingPortalHeaderSection(),
          const AdverseEventReportingPortalFilterBarSection(),
          const AdverseEventReportingPortalMetricsSummarySection(),
          const AdverseEventReportingPortalChartAreaSection(),
          const AdverseEventReportingPortalExportActionsSection(),
        ],
      ),
    );
  }
}
