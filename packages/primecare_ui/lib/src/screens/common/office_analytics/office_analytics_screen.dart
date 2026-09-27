import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'office_analytics_screen_controller.dart';
import 'sections/office_analytics_header_section.dart';
import 'sections/office_analytics_filter_bar_section.dart';
import 'sections/office_analytics_metrics_summary_section.dart';
import 'sections/office_analytics_chart_area_section.dart';
import 'sections/office_analytics_export_actions_section.dart';


class OfficeAnalyticsScreen extends ConsumerWidget {
  const OfficeAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(office_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('OfficeAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(office_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('office_analytics_loading'), child: Semantics(label: 'office_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('office_analytics_screen'),
                    child: Column(
                      children: [
                        OfficeAnalyticsHeaderSection(data: state.data),
                        OfficeAnalyticsFilterBarSection(data: state.data),
                        OfficeAnalyticsMetricsSummarySection(data: state.data),
                        OfficeAnalyticsChartAreaSection(data: state.data),
                        OfficeAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
