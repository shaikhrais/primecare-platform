import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'head_of_bus_dev_analytics_screen_controller.dart';
import 'sections/head_of_bus_dev_analytics_header_section.dart';
import 'sections/head_of_bus_dev_analytics_filter_bar_section.dart';
import 'sections/head_of_bus_dev_analytics_metrics_summary_section.dart';
import 'sections/head_of_bus_dev_analytics_chart_area_section.dart';
import 'sections/head_of_bus_dev_analytics_export_actions_section.dart';


class HeadOfBusDevAnalyticsScreen extends ConsumerWidget {
  const HeadOfBusDevAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(head_of_bus_dev_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HeadOfBusDevAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(head_of_bus_dev_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('head_of_bus_dev_analytics_loading'), child: Semantics(label: 'head_of_bus_dev_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('head_of_bus_dev_analytics_screen'),
                    child: Column(
                      children: [
                        HeadOfBusDevAnalyticsHeaderSection(data: state.data),
                        HeadOfBusDevAnalyticsFilterBarSection(data: state.data),
                        HeadOfBusDevAnalyticsMetricsSummarySection(data: state.data),
                        HeadOfBusDevAnalyticsChartAreaSection(data: state.data),
                        HeadOfBusDevAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
