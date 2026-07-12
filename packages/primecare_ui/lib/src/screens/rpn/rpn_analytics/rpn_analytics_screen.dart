import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rpn_analytics_screen_controller.dart';
import 'sections/rpn_analytics_header_section.dart';
import 'sections/rpn_analytics_filter_bar_section.dart';
import 'sections/rpn_analytics_metrics_summary_section.dart';
import 'sections/rpn_analytics_chart_area_section.dart';
import 'sections/rpn_analytics_export_actions_section.dart';


class RpnAnalyticsScreen extends ConsumerWidget {
  const RpnAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rpn_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RpnAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rpn_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rpn_analytics_loading'), child: Semantics(label: 'rpn_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rpn_analytics_screen'),
                    child: Column(
                      children: [
                        RpnAnalyticsHeaderSection(data: state.data),
                        RpnAnalyticsFilterBarSection(data: state.data),
                        RpnAnalyticsMetricsSummarySection(data: state.data),
                        RpnAnalyticsChartAreaSection(data: state.data),
                        RpnAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
