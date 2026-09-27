import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'qa_analytics_screen_controller.dart';
import 'sections/qa_analytics_header_section.dart';
import 'sections/qa_analytics_filter_bar_section.dart';
import 'sections/qa_analytics_metrics_summary_section.dart';
import 'sections/qa_analytics_chart_area_section.dart';
import 'sections/qa_analytics_export_actions_section.dart';


class QaAnalyticsScreen extends ConsumerWidget {
  const QaAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(qa_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('QaAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(qa_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('qa_analytics_loading'), child: Semantics(label: 'qa_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('qa_analytics_screen'),
                    child: Column(
                      children: [
                        QaAnalyticsHeaderSection(data: state.data),
                        QaAnalyticsFilterBarSection(data: state.data),
                        QaAnalyticsMetricsSummarySection(data: state.data),
                        QaAnalyticsChartAreaSection(data: state.data),
                        QaAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
