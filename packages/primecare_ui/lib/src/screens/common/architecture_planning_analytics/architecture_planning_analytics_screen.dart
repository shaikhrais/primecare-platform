import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'architecture_planning_analytics_screen_controller.dart';
import 'sections/architecture_planning_analytics_header_section.dart';
import 'sections/architecture_planning_analytics_filter_bar_section.dart';
import 'sections/architecture_planning_analytics_metrics_summary_section.dart';
import 'sections/architecture_planning_analytics_chart_area_section.dart';
import 'sections/architecture_planning_analytics_export_actions_section.dart';


class ArchitecturePlanningAnalyticsScreen extends ConsumerWidget {
  const ArchitecturePlanningAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(architecture_planning_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ArchitecturePlanningAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(architecture_planning_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('architecture_planning_analytics_loading'), child: Semantics(label: 'architecture_planning_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('architecture_planning_analytics_screen'),
                    child: Column(
                      children: [
                        ArchitecturePlanningAnalyticsHeaderSection(data: state.data),
                        ArchitecturePlanningAnalyticsFilterBarSection(data: state.data),
                        ArchitecturePlanningAnalyticsMetricsSummarySection(data: state.data),
                        ArchitecturePlanningAnalyticsChartAreaSection(data: state.data),
                        ArchitecturePlanningAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
