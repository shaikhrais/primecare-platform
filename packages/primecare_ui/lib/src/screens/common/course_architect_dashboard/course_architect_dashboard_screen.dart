import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'course_architect_dashboard_screen_controller.dart';
import 'sections/course_architect_dashboard_header_section.dart';
import 'sections/course_architect_dashboard_summary_cards_section.dart';
import 'sections/course_architect_dashboard_chart_overview_section.dart';
import 'sections/course_architect_dashboard_recent_activity_section.dart';
import 'sections/course_architect_dashboard_quick_actions_section.dart';


class CourseArchitectDashboardScreen extends ConsumerWidget {
  const CourseArchitectDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(course_architect_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CourseArchitectDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(course_architect_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('course_architect_dashboard_loading'), child: Semantics(label: 'course_architect_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('course_architect_dashboard_screen'),
                    child: Column(
                      children: [
                        CourseArchitectDashboardHeaderSection(data: state.data),
                        CourseArchitectDashboardSummaryCardsSection(data: state.data),
                        CourseArchitectDashboardChartOverviewSection(data: state.data),
                        CourseArchitectDashboardRecentActivitySection(data: state.data),
                        CourseArchitectDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
