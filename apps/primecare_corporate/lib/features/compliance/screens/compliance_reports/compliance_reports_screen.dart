import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/compliance_reports_header_section.dart';
import 'sections/compliance_reports_filter_bar_section.dart';
import 'sections/compliance_reports_metrics_summary_section.dart';
import 'sections/compliance_reports_chart_area_section.dart';
import 'sections/compliance_reports_export_actions_section.dart';

class ComplianceReportsScreen extends StatelessWidget {
  const ComplianceReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'compliance_reports',
      title: 'Compliance Reports',
      child: Column(
        children: const [
          const ComplianceReportsHeaderSection(),
          const ComplianceReportsFilterBarSection(),
          const ComplianceReportsMetricsSummarySection(),
          const ComplianceReportsChartAreaSection(),
          const ComplianceReportsExportActionsSection(),
        ],
      ),
    );
  }
}
