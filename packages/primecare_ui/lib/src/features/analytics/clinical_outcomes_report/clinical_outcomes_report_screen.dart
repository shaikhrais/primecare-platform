import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinical_outcomes_report_header_section.dart';
import 'sections/clinical_outcomes_report_filter_bar_section.dart';
import 'sections/clinical_outcomes_report_metrics_summary_section.dart';
import 'sections/clinical_outcomes_report_chart_area_section.dart';
import 'sections/clinical_outcomes_report_export_actions_section.dart';

class ClinicalOutcomesReportScreen extends StatelessWidget {
  const ClinicalOutcomesReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinical_outcomes_report',
      title: 'Clinical Outcomes Report',
      child: Column(
        children: const [
          const ClinicalOutcomesReportHeaderSection(),
          const ClinicalOutcomesReportFilterBarSection(),
          const ClinicalOutcomesReportMetricsSummarySection(),
          const ClinicalOutcomesReportChartAreaSection(),
          const ClinicalOutcomesReportExportActionsSection(),
        ],
      ),
    );
  }
}
