import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'legal_analytics_screen_controller.dart';
import 'sections/legal_analytics_header_section.dart';
import 'sections/legal_analytics_filter_bar_section.dart';
import 'sections/legal_analytics_metrics_summary_section.dart';
import 'sections/legal_analytics_chart_area_section.dart';
import 'sections/legal_analytics_export_actions_section.dart';


class LegalAnalyticsScreen extends ConsumerWidget {
  const LegalAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(legal_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('LegalAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(legal_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('legal_analytics_loading'), child: Semantics(label: 'legal_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('legal_analytics_screen'),
                    child: Column(
                      children: [
                        LegalAnalyticsHeaderSection(data: state.data),
                        LegalAnalyticsFilterBarSection(data: state.data),
                        LegalAnalyticsMetricsSummarySection(data: state.data),
                        LegalAnalyticsChartAreaSection(data: state.data),
                        LegalAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
