import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_director_analytics_header_section.dart';
import 'sections/hr_director_analytics_filter_bar_section.dart';
import 'sections/hr_director_analytics_metrics_summary_section.dart';
import 'sections/hr_director_analytics_chart_area_section.dart';
import 'sections/hr_director_analytics_export_actions_section.dart';

class HrDirectorAnalyticsScreen extends StatelessWidget {
  const HrDirectorAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_director_analytics',
      title: 'HrDirectorAnalyticsScreen',
      child: Column(
        children: const [
          const HrDirectorAnalyticsHeaderSection(),
          const HrDirectorAnalyticsFilterBarSection(),
          const HrDirectorAnalyticsMetricsSummarySection(),
          const HrDirectorAnalyticsChartAreaSection(),
          const HrDirectorAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
