import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/intake_coordinator_reports_header_section.dart';
import 'sections/intake_coordinator_reports_filter_bar_section.dart';
import 'sections/intake_coordinator_reports_metrics_summary_section.dart';
import 'sections/intake_coordinator_reports_chart_area_section.dart';
import 'sections/intake_coordinator_reports_export_actions_section.dart';

class IntakeCoordinatorReportsScreen extends StatelessWidget {
  const IntakeCoordinatorReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'intake_coordinator_reports',
      title: 'Intake Coordinator Reports',
      child: Column(
        children: const [
          const IntakeCoordinatorReportsHeaderSection(),
          const IntakeCoordinatorReportsFilterBarSection(),
          const IntakeCoordinatorReportsMetricsSummarySection(),
          const IntakeCoordinatorReportsChartAreaSection(),
          const IntakeCoordinatorReportsExportActionsSection(),
        ],
      ),
    );
  }
}
