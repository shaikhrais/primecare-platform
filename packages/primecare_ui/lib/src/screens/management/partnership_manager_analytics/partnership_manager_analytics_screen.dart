import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'partnership_manager_analytics_screen_controller.dart';
import 'sections/partnership_manager_analytics_header_section.dart';
import 'sections/partnership_manager_analytics_filter_bar_section.dart';
import 'sections/partnership_manager_analytics_metrics_summary_section.dart';
import 'sections/partnership_manager_analytics_chart_area_section.dart';
import 'sections/partnership_manager_analytics_export_actions_section.dart';


class PartnershipManagerAnalyticsScreen extends ConsumerWidget {
  const PartnershipManagerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(partnership_manager_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PartnershipManagerAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(partnership_manager_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('partnership_manager_analytics_loading'), child: Semantics(label: 'partnership_manager_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('partnership_manager_analytics_screen'),
                    child: Column(
                      children: [
                        PartnershipManagerAnalyticsHeaderSection(data: state.data),
                        PartnershipManagerAnalyticsFilterBarSection(data: state.data),
                        PartnershipManagerAnalyticsMetricsSummarySection(data: state.data),
                        PartnershipManagerAnalyticsChartAreaSection(data: state.data),
                        PartnershipManagerAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
