import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'coo_analytics_screen_controller.dart';
import 'sections/coo_analytics_header_section.dart';
import 'sections/coo_analytics_filter_bar_section.dart';
import 'sections/coo_analytics_metrics_summary_section.dart';
import 'sections/coo_analytics_chart_area_section.dart';
import 'sections/coo_analytics_export_actions_section.dart';


class CooAnalyticsScreen extends ConsumerWidget {
  const CooAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coo_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CooAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(coo_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('coo_analytics_loading'), child: Semantics(label: 'coo_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('coo_analytics_screen'),
                    child: Column(
                      children: [
                        CooAnalyticsHeaderSection(data: state.data),
                        CooAnalyticsFilterBarSection(data: state.data),
                        CooAnalyticsMetricsSummarySection(data: state.data),
                        CooAnalyticsChartAreaSection(data: state.data),
                        CooAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
