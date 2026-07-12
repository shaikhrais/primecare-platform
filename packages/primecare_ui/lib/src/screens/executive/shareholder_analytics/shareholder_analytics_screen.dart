import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'shareholder_analytics_screen_controller.dart';
import 'sections/shareholder_analytics_header_section.dart';
import 'sections/shareholder_analytics_filter_bar_section.dart';
import 'sections/shareholder_analytics_metrics_summary_section.dart';
import 'sections/shareholder_analytics_chart_area_section.dart';
import 'sections/shareholder_analytics_export_actions_section.dart';


class ShareholderAnalyticsScreen extends ConsumerWidget {
  const ShareholderAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(shareholder_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ShareholderAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(shareholder_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('shareholder_analytics_loading'), child: Semantics(label: 'shareholder_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('shareholder_analytics_screen'),
                    child: Column(
                      children: [
                        ShareholderAnalyticsHeaderSection(data: state.data),
                        ShareholderAnalyticsFilterBarSection(data: state.data),
                        ShareholderAnalyticsMetricsSummarySection(data: state.data),
                        ShareholderAnalyticsChartAreaSection(data: state.data),
                        ShareholderAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
