import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'lead_analytics_screen_controller.dart';
import 'sections/lead_analytics_header_section.dart';
import 'sections/lead_analytics_filter_bar_section.dart';
import 'sections/lead_analytics_metrics_summary_section.dart';
import 'sections/lead_analytics_chart_area_section.dart';
import 'sections/lead_analytics_export_actions_section.dart';


class LeadAnalyticsScreen extends ConsumerWidget {
  const LeadAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(lead_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('LeadAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(lead_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('lead_analytics_loading'), child: Semantics(label: 'lead_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('lead_analytics_screen'),
                    child: Column(
                      children: [
                        LeadAnalyticsHeaderSection(data: state.data),
                        LeadAnalyticsFilterBarSection(data: state.data),
                        LeadAnalyticsMetricsSummarySection(data: state.data),
                        LeadAnalyticsChartAreaSection(data: state.data),
                        LeadAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
