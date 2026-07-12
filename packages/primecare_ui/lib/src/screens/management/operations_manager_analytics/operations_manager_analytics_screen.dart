import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'operations_manager_analytics_screen_controller.dart';
import 'sections/operations_manager_analytics_header_section.dart';
import 'sections/operations_manager_analytics_filter_bar_section.dart';
import 'sections/operations_manager_analytics_metrics_summary_section.dart';
import 'sections/operations_manager_analytics_chart_area_section.dart';
import 'sections/operations_manager_analytics_export_actions_section.dart';


class OperationsManagerAnalyticsScreen extends ConsumerWidget {
  const OperationsManagerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(operations_manager_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('OperationsManagerAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(operations_manager_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('operations_manager_analytics_loading'), child: Semantics(label: 'operations_manager_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('operations_manager_analytics_screen'),
                    child: Column(
                      children: [
                        OperationsManagerAnalyticsHeaderSection(data: state.data),
                        OperationsManagerAnalyticsFilterBarSection(data: state.data),
                        OperationsManagerAnalyticsMetricsSummarySection(data: state.data),
                        OperationsManagerAnalyticsChartAreaSection(data: state.data),
                        OperationsManagerAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
