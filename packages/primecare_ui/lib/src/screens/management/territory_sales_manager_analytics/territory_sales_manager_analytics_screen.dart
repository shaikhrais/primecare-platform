import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'territory_sales_manager_analytics_screen_controller.dart';
import 'sections/territory_sales_manager_analytics_header_section.dart';
import 'sections/territory_sales_manager_analytics_filter_bar_section.dart';
import 'sections/territory_sales_manager_analytics_metrics_summary_section.dart';
import 'sections/territory_sales_manager_analytics_chart_area_section.dart';
import 'sections/territory_sales_manager_analytics_export_actions_section.dart';


class TerritorySalesManagerAnalyticsScreen extends ConsumerWidget {
  const TerritorySalesManagerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(territory_sales_manager_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('TerritorySalesManagerAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(territory_sales_manager_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('territory_sales_manager_analytics_loading'), child: Semantics(label: 'territory_sales_manager_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('territory_sales_manager_analytics_screen'),
                    child: Column(
                      children: [
                        TerritorySalesManagerAnalyticsHeaderSection(data: state.data),
                        TerritorySalesManagerAnalyticsFilterBarSection(data: state.data),
                        TerritorySalesManagerAnalyticsMetricsSummarySection(data: state.data),
                        TerritorySalesManagerAnalyticsChartAreaSection(data: state.data),
                        TerritorySalesManagerAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
