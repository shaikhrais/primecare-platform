import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'infrastructure_analytics_screen_controller.dart';
import 'sections/infrastructure_analytics_header_section.dart';
import 'sections/infrastructure_analytics_filter_bar_section.dart';
import 'sections/infrastructure_analytics_metrics_summary_section.dart';
import 'sections/infrastructure_analytics_chart_area_section.dart';
import 'sections/infrastructure_analytics_export_actions_section.dart';


class InfrastructureAnalyticsScreen extends ConsumerWidget {
  const InfrastructureAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(infrastructure_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('InfrastructureAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(infrastructure_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('infrastructure_analytics_loading'), child: Semantics(label: 'infrastructure_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('infrastructure_analytics_screen'),
                    child: Column(
                      children: [
                        InfrastructureAnalyticsHeaderSection(data: state.data),
                        InfrastructureAnalyticsFilterBarSection(data: state.data),
                        InfrastructureAnalyticsMetricsSummarySection(data: state.data),
                        InfrastructureAnalyticsChartAreaSection(data: state.data),
                        InfrastructureAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
