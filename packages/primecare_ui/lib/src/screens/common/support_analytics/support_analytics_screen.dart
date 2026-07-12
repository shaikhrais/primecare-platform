import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'support_analytics_screen_controller.dart';
import 'sections/support_analytics_header_section.dart';
import 'sections/support_analytics_filter_bar_section.dart';
import 'sections/support_analytics_metrics_summary_section.dart';
import 'sections/support_analytics_chart_area_section.dart';
import 'sections/support_analytics_export_actions_section.dart';


class SupportAnalyticsScreen extends ConsumerWidget {
  const SupportAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(support_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SupportAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(support_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('support_analytics_loading'), child: Semantics(label: 'support_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('support_analytics_screen'),
                    child: Column(
                      children: [
                        SupportAnalyticsHeaderSection(data: state.data),
                        SupportAnalyticsFilterBarSection(data: state.data),
                        SupportAnalyticsMetricsSummarySection(data: state.data),
                        SupportAnalyticsChartAreaSection(data: state.data),
                        SupportAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
