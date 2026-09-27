import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'intake_coordinator_analytics_screen_controller.dart';
import 'sections/intake_coordinator_analytics_header_section.dart';
import 'sections/intake_coordinator_analytics_filter_bar_section.dart';
import 'sections/intake_coordinator_analytics_metrics_summary_section.dart';
import 'sections/intake_coordinator_analytics_chart_area_section.dart';
import 'sections/intake_coordinator_analytics_export_actions_section.dart';


class IntakeCoordinatorAnalyticsScreen extends ConsumerWidget {
  const IntakeCoordinatorAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(intake_coordinator_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('IntakeCoordinatorAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(intake_coordinator_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('intake_coordinator_analytics_loading'), child: Semantics(label: 'intake_coordinator_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('intake_coordinator_analytics_screen'),
                    child: Column(
                      children: [
                        IntakeCoordinatorAnalyticsHeaderSection(data: state.data),
                        IntakeCoordinatorAnalyticsFilterBarSection(data: state.data),
                        IntakeCoordinatorAnalyticsMetricsSummarySection(data: state.data),
                        IntakeCoordinatorAnalyticsChartAreaSection(data: state.data),
                        IntakeCoordinatorAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
