import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rmt_analytics_screen_controller.dart';
import 'sections/rmt_analytics_header_section.dart';
import 'sections/rmt_analytics_filter_bar_section.dart';
import 'sections/rmt_analytics_metrics_summary_section.dart';
import 'sections/rmt_analytics_chart_area_section.dart';
import 'sections/rmt_analytics_export_actions_section.dart';


class RmtAnalyticsScreen extends ConsumerWidget {
  const RmtAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rmt_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RmtAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rmt_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rmt_analytics_loading'), child: Semantics(label: 'rmt_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rmt_analytics_screen'),
                    child: Column(
                      children: [
                        RmtAnalyticsHeaderSection(data: state.data),
                        RmtAnalyticsFilterBarSection(data: state.data),
                        RmtAnalyticsMetricsSummarySection(data: state.data),
                        RmtAnalyticsChartAreaSection(data: state.data),
                        RmtAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
