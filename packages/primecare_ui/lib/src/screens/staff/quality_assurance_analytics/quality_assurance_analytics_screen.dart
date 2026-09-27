import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'quality_assurance_analytics_screen_controller.dart';
import 'sections/quality_assurance_analytics_header_section.dart';
import 'sections/quality_assurance_analytics_filter_bar_section.dart';
import 'sections/quality_assurance_analytics_metrics_summary_section.dart';
import 'sections/quality_assurance_analytics_chart_area_section.dart';
import 'sections/quality_assurance_analytics_export_actions_section.dart';


class QualityAssuranceAnalyticsScreen extends ConsumerWidget {
  const QualityAssuranceAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quality_assurance_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('QualityAssuranceAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(quality_assurance_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('quality_assurance_analytics_loading'), child: Semantics(label: 'quality_assurance_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('quality_assurance_analytics_screen'),
                    child: Column(
                      children: [
                        QualityAssuranceAnalyticsHeaderSection(data: state.data),
                        QualityAssuranceAnalyticsFilterBarSection(data: state.data),
                        QualityAssuranceAnalyticsMetricsSummarySection(data: state.data),
                        QualityAssuranceAnalyticsChartAreaSection(data: state.data),
                        QualityAssuranceAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
