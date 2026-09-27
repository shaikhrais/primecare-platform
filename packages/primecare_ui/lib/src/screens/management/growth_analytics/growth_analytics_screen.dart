import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'growth_analytics_screen_controller.dart';
import 'sections/growth_analytics_header_section.dart';
import 'sections/growth_analytics_filter_bar_section.dart';
import 'sections/growth_analytics_metrics_summary_section.dart';
import 'sections/growth_analytics_chart_area_section.dart';
import 'sections/growth_analytics_export_actions_section.dart';


class GrowthAnalyticsScreen extends ConsumerWidget {
  const GrowthAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(growth_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('GrowthAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(growth_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('growth_analytics_loading'), child: Semantics(label: 'growth_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('growth_analytics_screen'),
                    child: Column(
                      children: [
                        GrowthAnalyticsHeaderSection(data: state.data),
                        GrowthAnalyticsFilterBarSection(data: state.data),
                        GrowthAnalyticsMetricsSummarySection(data: state.data),
                        GrowthAnalyticsChartAreaSection(data: state.data),
                        GrowthAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
