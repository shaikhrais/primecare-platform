import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/course_architect_analytics_header_section.dart';
import 'sections/course_architect_analytics_filter_bar_section.dart';
import 'sections/course_architect_analytics_metrics_summary_section.dart';
import 'sections/course_architect_analytics_chart_area_section.dart';
import 'sections/course_architect_analytics_export_actions_section.dart';

class CourseArchitectAnalyticsScreen extends StatelessWidget {
  const CourseArchitectAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'course_architect_analytics',
      title: 'CourseArchitectAnalyticsScreen',
      child: Column(
        children: const [
          const CourseArchitectAnalyticsHeaderSection(),
          const CourseArchitectAnalyticsFilterBarSection(),
          const CourseArchitectAnalyticsMetricsSummarySection(),
          const CourseArchitectAnalyticsChartAreaSection(),
          const CourseArchitectAnalyticsExportActionsSection(),
        ],
      ),
    );
  }
}
