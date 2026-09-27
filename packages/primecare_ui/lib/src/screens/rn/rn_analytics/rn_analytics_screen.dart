import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rn_analytics_screen_controller.dart';
import 'sections/rn_analytics_header_section.dart';
import 'sections/rn_analytics_filter_bar_section.dart';
import 'sections/rn_analytics_metrics_summary_section.dart';
import 'sections/rn_analytics_chart_area_section.dart';
import 'sections/rn_analytics_export_actions_section.dart';


class RnAnalyticsScreen extends ConsumerWidget {
  const RnAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rn_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RnAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rn_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rn_analytics_loading'), child: Semantics(label: 'rn_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rn_analytics_screen'),
                    child: Column(
                      children: [
                        RnAnalyticsHeaderSection(data: state.data),
                        RnAnalyticsFilterBarSection(data: state.data),
                        RnAnalyticsMetricsSummarySection(data: state.data),
                        RnAnalyticsChartAreaSection(data: state.data),
                        RnAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
