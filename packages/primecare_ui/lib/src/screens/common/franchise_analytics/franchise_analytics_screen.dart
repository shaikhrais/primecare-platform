import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'franchise_analytics_screen_controller.dart';
import 'sections/franchise_analytics_header_section.dart';
import 'sections/franchise_analytics_filter_bar_section.dart';
import 'sections/franchise_analytics_metrics_summary_section.dart';
import 'sections/franchise_analytics_chart_area_section.dart';
import 'sections/franchise_analytics_export_actions_section.dart';


class FranchiseAnalyticsScreen extends ConsumerWidget {
  const FranchiseAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(franchise_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FranchiseAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(franchise_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('franchise_analytics_loading'), child: Semantics(label: 'franchise_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('franchise_analytics_screen'),
                    child: Column(
                      children: [
                        FranchiseAnalyticsHeaderSection(data: state.data),
                        FranchiseAnalyticsFilterBarSection(data: state.data),
                        FranchiseAnalyticsMetricsSummarySection(data: state.data),
                        FranchiseAnalyticsChartAreaSection(data: state.data),
                        FranchiseAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
