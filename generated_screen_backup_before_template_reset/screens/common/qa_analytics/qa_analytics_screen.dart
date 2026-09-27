import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/qa_analytics_header_section.dart';
import 'sections/qa_analytics_filter_bar_section.dart';
import 'sections/qa_analytics_metrics_summary_section.dart';
import 'sections/qa_analytics_chart_area_section.dart';
import 'sections/qa_analytics_export_actions_section.dart';

class QaAnalyticsScreen extends StatelessWidget {
  const QaAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'qa_analytics',
      title: 'QaAnalyticsScreen',
      child: Column(
        children: const [
          const QaAnalyticsHeaderSection(),
          const QaAnalyticsFilterBarSection(),
          const QaAnalyticsMetricsSummarySection(),
          const QaAnalyticsChartAreaSection(),
          const QaAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
