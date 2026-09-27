import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'intake_analytics_screen_controller.dart';
import 'sections/intake_analytics_header_section.dart';
import 'sections/intake_analytics_filter_bar_section.dart';
import 'sections/intake_analytics_metrics_summary_section.dart';
import 'sections/intake_analytics_chart_area_section.dart';
import 'sections/intake_analytics_export_actions_section.dart';


class IntakeAnalyticsScreen extends ConsumerWidget {
  const IntakeAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(intake_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('IntakeAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(intake_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('intake_analytics_loading'), child: Semantics(label: 'intake_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('intake_analytics_screen'),
                    child: Column(
                      children: [
                        IntakeAnalyticsHeaderSection(data: state.data),
                        IntakeAnalyticsFilterBarSection(data: state.data),
                        IntakeAnalyticsMetricsSummarySection(data: state.data),
                        IntakeAnalyticsChartAreaSection(data: state.data),
                        IntakeAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
