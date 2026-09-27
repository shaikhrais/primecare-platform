import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'portal_analytics_screen_controller.dart';
import 'sections/portal_analytics_header_section.dart';
import 'sections/portal_analytics_filter_bar_section.dart';
import 'sections/portal_analytics_metrics_summary_section.dart';
import 'sections/portal_analytics_chart_area_section.dart';
import 'sections/portal_analytics_export_actions_section.dart';


class PortalAnalyticsScreen extends ConsumerWidget {
  const PortalAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(portal_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PortalAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(portal_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('portal_analytics_loading'), child: Semantics(label: 'portal_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('portal_analytics_screen'),
                    child: Column(
                      children: [
                        PortalAnalyticsHeaderSection(data: state.data),
                        PortalAnalyticsFilterBarSection(data: state.data),
                        PortalAnalyticsMetricsSummarySection(data: state.data),
                        PortalAnalyticsChartAreaSection(data: state.data),
                        PortalAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
