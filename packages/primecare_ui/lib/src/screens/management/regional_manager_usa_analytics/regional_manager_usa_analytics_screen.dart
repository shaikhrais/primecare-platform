import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'regional_manager_usa_analytics_screen_controller.dart';
import 'sections/regional_manager_usa_analytics_header_section.dart';
import 'sections/regional_manager_usa_analytics_filter_bar_section.dart';
import 'sections/regional_manager_usa_analytics_metrics_summary_section.dart';
import 'sections/regional_manager_usa_analytics_chart_area_section.dart';
import 'sections/regional_manager_usa_analytics_export_actions_section.dart';


class RegionalManagerUsaAnalyticsScreen extends ConsumerWidget {
  const RegionalManagerUsaAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(regional_manager_usa_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RegionalManagerUsaAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(regional_manager_usa_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('regional_manager_usa_analytics_loading'), child: Semantics(label: 'regional_manager_usa_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('regional_manager_usa_analytics_screen'),
                    child: Column(
                      children: [
                        RegionalManagerUsaAnalyticsHeaderSection(data: state.data),
                        RegionalManagerUsaAnalyticsFilterBarSection(data: state.data),
                        RegionalManagerUsaAnalyticsMetricsSummarySection(data: state.data),
                        RegionalManagerUsaAnalyticsChartAreaSection(data: state.data),
                        RegionalManagerUsaAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
