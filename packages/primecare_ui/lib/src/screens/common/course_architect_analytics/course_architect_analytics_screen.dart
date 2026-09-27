import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'course_architect_analytics_screen_controller.dart';
import 'sections/course_architect_analytics_header_section.dart';
import 'sections/course_architect_analytics_filter_bar_section.dart';
import 'sections/course_architect_analytics_metrics_summary_section.dart';
import 'sections/course_architect_analytics_chart_area_section.dart';
import 'sections/course_architect_analytics_export_actions_section.dart';


class CourseArchitectAnalyticsScreen extends ConsumerWidget {
  const CourseArchitectAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(course_architect_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CourseArchitectAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(course_architect_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('course_architect_analytics_loading'), child: Semantics(label: 'course_architect_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('course_architect_analytics_screen'),
                    child: Column(
                      children: [
                        CourseArchitectAnalyticsHeaderSection(data: state.data),
                        CourseArchitectAnalyticsFilterBarSection(data: state.data),
                        CourseArchitectAnalyticsMetricsSummarySection(data: state.data),
                        CourseArchitectAnalyticsChartAreaSection(data: state.data),
                        CourseArchitectAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
