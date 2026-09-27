import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'clinical_analytics_screen_controller.dart';
import 'sections/clinical_analytics_header_section.dart';
import 'sections/clinical_analytics_filter_bar_section.dart';
import 'sections/clinical_analytics_metrics_summary_section.dart';
import 'sections/clinical_analytics_chart_area_section.dart';
import 'sections/clinical_analytics_export_actions_section.dart';


class ClinicalAnalyticsScreen extends ConsumerWidget {
  const ClinicalAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinical_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ClinicalAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(clinical_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('clinical_analytics_loading'), child: Semantics(label: 'clinical_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('clinical_analytics_screen'),
                    child: Column(
                      children: [
                        ClinicalAnalyticsHeaderSection(data: state.data),
                        ClinicalAnalyticsFilterBarSection(data: state.data),
                        ClinicalAnalyticsMetricsSummarySection(data: state.data),
                        ClinicalAnalyticsChartAreaSection(data: state.data),
                        ClinicalAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
