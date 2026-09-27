import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'physiotherapist_analytics_screen_controller.dart';
import 'sections/physiotherapist_analytics_header_section.dart';
import 'sections/physiotherapist_analytics_filter_bar_section.dart';
import 'sections/physiotherapist_analytics_metrics_summary_section.dart';
import 'sections/physiotherapist_analytics_chart_area_section.dart';
import 'sections/physiotherapist_analytics_export_actions_section.dart';


class PhysiotherapistAnalyticsScreen extends ConsumerWidget {
  const PhysiotherapistAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(physiotherapist_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PhysiotherapistAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(physiotherapist_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('physiotherapist_analytics_loading'), child: Semantics(label: 'physiotherapist_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('physiotherapist_analytics_screen'),
                    child: Column(
                      children: [
                        PhysiotherapistAnalyticsHeaderSection(data: state.data),
                        PhysiotherapistAnalyticsFilterBarSection(data: state.data),
                        PhysiotherapistAnalyticsMetricsSummarySection(data: state.data),
                        PhysiotherapistAnalyticsChartAreaSection(data: state.data),
                        PhysiotherapistAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
