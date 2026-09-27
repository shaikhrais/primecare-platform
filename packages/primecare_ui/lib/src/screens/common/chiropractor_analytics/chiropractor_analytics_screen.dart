import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'chiropractor_analytics_screen_controller.dart';
import 'sections/chiropractor_analytics_header_section.dart';
import 'sections/chiropractor_analytics_filter_bar_section.dart';
import 'sections/chiropractor_analytics_metrics_summary_section.dart';
import 'sections/chiropractor_analytics_chart_area_section.dart';
import 'sections/chiropractor_analytics_export_actions_section.dart';


class ChiropractorAnalyticsScreen extends ConsumerWidget {
  const ChiropractorAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chiropractor_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ChiropractorAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(chiropractor_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('chiropractor_analytics_loading'), child: Semantics(label: 'chiropractor_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('chiropractor_analytics_screen'),
                    child: Column(
                      children: [
                        ChiropractorAnalyticsHeaderSection(data: state.data),
                        ChiropractorAnalyticsFilterBarSection(data: state.data),
                        ChiropractorAnalyticsMetricsSummarySection(data: state.data),
                        ChiropractorAnalyticsChartAreaSection(data: state.data),
                        ChiropractorAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
