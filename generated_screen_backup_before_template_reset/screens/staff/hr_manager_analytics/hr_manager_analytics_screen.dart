import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_manager_analytics_header_section.dart';
import 'sections/hr_manager_analytics_filter_bar_section.dart';
import 'sections/hr_manager_analytics_metrics_summary_section.dart';
import 'sections/hr_manager_analytics_chart_area_section.dart';
import 'sections/hr_manager_analytics_export_actions_section.dart';

class HrManagerAnalyticsScreen extends StatelessWidget {
  const HrManagerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_manager_analytics',
      title: 'HrManagerAnalyticsScreen',
      child: Column(
        children: const [
          const HrManagerAnalyticsHeaderSection(),
          const HrManagerAnalyticsFilterBarSection(),
          const HrManagerAnalyticsMetricsSummarySection(),
          const HrManagerAnalyticsChartAreaSection(),
          const HrManagerAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
