import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'therapist_analytics_screen_controller.dart';
import 'sections/therapist_analytics_header_section.dart';
import 'sections/therapist_analytics_filter_bar_section.dart';
import 'sections/therapist_analytics_metrics_summary_section.dart';
import 'sections/therapist_analytics_chart_area_section.dart';
import 'sections/therapist_analytics_export_actions_section.dart';


class TherapistAnalyticsScreen extends ConsumerWidget {
  const TherapistAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(therapist_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Therapist Analytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(therapist_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('therapist_analytics_loading'), child: Semantics(label: 'therapist_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('therapist_analytics_screen'),
                    child: Column(
                      children: [
                        TherapistAnalyticsHeaderSection(data: state.data),
                        TherapistAnalyticsFilterBarSection(data: state.data),
                        TherapistAnalyticsMetricsSummarySection(data: state.data),
                        TherapistAnalyticsChartAreaSection(data: state.data),
                        TherapistAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
