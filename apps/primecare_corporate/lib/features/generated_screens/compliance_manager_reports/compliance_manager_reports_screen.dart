import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/compliance_manager_reports_header_section.dart';
import 'sections/compliance_manager_reports_filter_bar_section.dart';
import 'sections/compliance_manager_reports_metrics_summary_section.dart';
import 'sections/compliance_manager_reports_chart_area_section.dart';
import 'sections/compliance_manager_reports_export_actions_section.dart';

class ComplianceManagerReportsScreen extends StatelessWidget {
  const ComplianceManagerReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'compliance_manager_reports',
      title: 'Compliance Manager Reports',
      child: Column(
        children: const [
          const ComplianceManagerReportsHeaderSection(),
          const ComplianceManagerReportsFilterBarSection(),
          const ComplianceManagerReportsMetricsSummarySection(),
          const ComplianceManagerReportsChartAreaSection(),
          const ComplianceManagerReportsExportActionsSection(),
        ],
      ),
    );
  }
}
