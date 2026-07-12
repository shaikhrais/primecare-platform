import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'volunteer_coordinator_analytics_screen_controller.dart';
import 'sections/volunteer_coordinator_analytics_header_section.dart';
import 'sections/volunteer_coordinator_analytics_filter_bar_section.dart';
import 'sections/volunteer_coordinator_analytics_metrics_summary_section.dart';
import 'sections/volunteer_coordinator_analytics_chart_area_section.dart';
import 'sections/volunteer_coordinator_analytics_export_actions_section.dart';


class VolunteerCoordinatorAnalyticsScreen extends ConsumerWidget {
  const VolunteerCoordinatorAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(volunteer_coordinator_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('VolunteerCoordinatorAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(volunteer_coordinator_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('volunteer_coordinator_analytics_loading'), child: Semantics(label: 'volunteer_coordinator_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('volunteer_coordinator_analytics_screen'),
                    child: Column(
                      children: [
                        VolunteerCoordinatorAnalyticsHeaderSection(data: state.data),
                        VolunteerCoordinatorAnalyticsFilterBarSection(data: state.data),
                        VolunteerCoordinatorAnalyticsMetricsSummarySection(data: state.data),
                        VolunteerCoordinatorAnalyticsChartAreaSection(data: state.data),
                        VolunteerCoordinatorAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
