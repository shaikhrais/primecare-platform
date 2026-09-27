import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/quality_assurance_reports_header_section.dart';
import 'sections/quality_assurance_reports_filter_bar_section.dart';
import 'sections/quality_assurance_reports_metrics_summary_section.dart';
import 'sections/quality_assurance_reports_chart_area_section.dart';
import 'sections/quality_assurance_reports_export_actions_section.dart';

class QualityAssuranceReportsScreen extends StatelessWidget {
  const QualityAssuranceReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'quality_assurance_reports',
      title: 'Quality Assurance Reports',
      child: Column(
        children: const [
          const QualityAssuranceReportsHeaderSection(),
          const QualityAssuranceReportsFilterBarSection(),
          const QualityAssuranceReportsMetricsSummarySection(),
          const QualityAssuranceReportsChartAreaSection(),
          const QualityAssuranceReportsExportActionsSection(),
        ],
      ),
    );
  }
}
