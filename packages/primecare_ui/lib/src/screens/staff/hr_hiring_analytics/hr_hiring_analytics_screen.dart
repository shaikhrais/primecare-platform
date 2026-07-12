import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'hr_hiring_analytics_screen_controller.dart';
import 'sections/hr_hiring_analytics_header_section.dart';
import 'sections/hr_hiring_analytics_filter_bar_section.dart';
import 'sections/hr_hiring_analytics_metrics_summary_section.dart';
import 'sections/hr_hiring_analytics_chart_area_section.dart';
import 'sections/hr_hiring_analytics_export_actions_section.dart';


class HrHiringAnalyticsScreen extends ConsumerWidget {
  const HrHiringAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hr_hiring_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HrHiringAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(hr_hiring_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('hr_hiring_analytics_loading'), child: Semantics(label: 'hr_hiring_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('hr_hiring_analytics_screen'),
                    child: Column(
                      children: [
                        HrHiringAnalyticsHeaderSection(data: state.data),
                        HrHiringAnalyticsFilterBarSection(data: state.data),
                        HrHiringAnalyticsMetricsSummarySection(data: state.data),
                        HrHiringAnalyticsChartAreaSection(data: state.data),
                        HrHiringAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
