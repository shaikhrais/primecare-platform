import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'scrum_master_analytics_screen_controller.dart';
import 'sections/scrum_master_analytics_header_section.dart';
import 'sections/scrum_master_analytics_filter_bar_section.dart';
import 'sections/scrum_master_analytics_metrics_summary_section.dart';
import 'sections/scrum_master_analytics_chart_area_section.dart';
import 'sections/scrum_master_analytics_export_actions_section.dart';


class ScrumMasterAnalyticsScreen extends ConsumerWidget {
  const ScrumMasterAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scrum_master_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ScrumMasterAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(scrum_master_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('scrum_master_analytics_loading'), child: Semantics(label: 'scrum_master_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('scrum_master_analytics_screen'),
                    child: Column(
                      children: [
                        ScrumMasterAnalyticsHeaderSection(data: state.data),
                        ScrumMasterAnalyticsFilterBarSection(data: state.data),
                        ScrumMasterAnalyticsMetricsSummarySection(data: state.data),
                        ScrumMasterAnalyticsChartAreaSection(data: state.data),
                        ScrumMasterAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
