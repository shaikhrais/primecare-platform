import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'head_of_marketing_analytics_screen_controller.dart';
import 'sections/head_of_marketing_analytics_header_section.dart';
import 'sections/head_of_marketing_analytics_filter_bar_section.dart';
import 'sections/head_of_marketing_analytics_metrics_summary_section.dart';
import 'sections/head_of_marketing_analytics_chart_area_section.dart';
import 'sections/head_of_marketing_analytics_export_actions_section.dart';


class HeadOfMarketingAnalyticsScreen extends ConsumerWidget {
  const HeadOfMarketingAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(head_of_marketing_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HeadOfMarketingAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(head_of_marketing_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('head_of_marketing_analytics_loading'), child: Semantics(label: 'head_of_marketing_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('head_of_marketing_analytics_screen'),
                    child: Column(
                      children: [
                        HeadOfMarketingAnalyticsHeaderSection(data: state.data),
                        HeadOfMarketingAnalyticsFilterBarSection(data: state.data),
                        HeadOfMarketingAnalyticsMetricsSummarySection(data: state.data),
                        HeadOfMarketingAnalyticsChartAreaSection(data: state.data),
                        HeadOfMarketingAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
