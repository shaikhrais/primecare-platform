import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'premium_concierge_analytics_screen_controller.dart';
import 'sections/premium_concierge_analytics_header_section.dart';
import 'sections/premium_concierge_analytics_filter_bar_section.dart';
import 'sections/premium_concierge_analytics_metrics_summary_section.dart';
import 'sections/premium_concierge_analytics_chart_area_section.dart';
import 'sections/premium_concierge_analytics_export_actions_section.dart';


class PremiumConciergeCareCoordinatorAnalyticsScreen extends ConsumerWidget {
  const PremiumConciergeCareCoordinatorAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(premium_concierge_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Premium Concierge Care Coordinator Analytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(premium_concierge_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('premium_concierge_analytics_loading'), child: Semantics(label: 'premium_concierge_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('premium_concierge_analytics_screen'),
                    child: Column(
                      children: [
                        PremiumConciergeAnalyticsHeaderSection(data: state.data),
                        PremiumConciergeAnalyticsFilterBarSection(data: state.data),
                        PremiumConciergeAnalyticsMetricsSummarySection(data: state.data),
                        PremiumConciergeAnalyticsChartAreaSection(data: state.data),
                        PremiumConciergeAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
