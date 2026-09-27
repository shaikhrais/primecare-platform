import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_hiring_analytics_header_section.dart';
import 'sections/hr_hiring_analytics_filter_bar_section.dart';
import 'sections/hr_hiring_analytics_metrics_summary_section.dart';
import 'sections/hr_hiring_analytics_chart_area_section.dart';
import 'sections/hr_hiring_analytics_export_actions_section.dart';

class HrHiringAnalyticsScreen extends StatelessWidget {
  const HrHiringAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_hiring_analytics',
      title: 'HrHiringAnalyticsScreen',
      child: Column(
        children: const [
          const HrHiringAnalyticsHeaderSection(),
          const HrHiringAnalyticsFilterBarSection(),
          const HrHiringAnalyticsMetricsSummarySection(),
          const HrHiringAnalyticsChartAreaSection(),
          const HrHiringAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
