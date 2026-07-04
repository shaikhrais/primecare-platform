import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinical_director_reports_header_section.dart';
import 'sections/clinical_director_reports_filter_bar_section.dart';
import 'sections/clinical_director_reports_metrics_summary_section.dart';
import 'sections/clinical_director_reports_chart_area_section.dart';
import 'sections/clinical_director_reports_export_actions_section.dart';

class ClinicalDirectorReportsScreen extends StatelessWidget {
  const ClinicalDirectorReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinical_director_reports',
      title: 'ClinicalDirectorReportsScreen',
      child: Column(
        children: const [
          const ClinicalDirectorReportsHeaderSection(),
          const ClinicalDirectorReportsFilterBarSection(),
          const ClinicalDirectorReportsMetricsSummarySection(),
          const ClinicalDirectorReportsChartAreaSection(),
          const ClinicalDirectorReportsExportActionsSection(),
        ],
      ),
    );
  }
}
