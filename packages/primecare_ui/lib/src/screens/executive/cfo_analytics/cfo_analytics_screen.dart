import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'cfo_analytics_screen_controller.dart';
import 'sections/cfo_analytics_header_section.dart';
import 'sections/cfo_analytics_filter_bar_section.dart';
import 'sections/cfo_analytics_metrics_summary_section.dart';
import 'sections/cfo_analytics_chart_area_section.dart';
import 'sections/cfo_analytics_export_actions_section.dart';


class CfoAnalyticsScreen extends ConsumerWidget {
  const CfoAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cfo_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CfoAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(cfo_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('cfo_analytics_loading'), child: Semantics(label: 'cfo_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('cfo_analytics_screen'),
                    child: Column(
                      children: [
                        CfoAnalyticsHeaderSection(data: state.data),
                        CfoAnalyticsFilterBarSection(data: state.data),
                        CfoAnalyticsMetricsSummarySection(data: state.data),
                        CfoAnalyticsChartAreaSection(data: state.data),
                        CfoAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
