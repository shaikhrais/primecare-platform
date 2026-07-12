import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'np_analytics_screen_controller.dart';
import 'sections/np_analytics_header_section.dart';
import 'sections/np_analytics_filter_bar_section.dart';
import 'sections/np_analytics_metrics_summary_section.dart';
import 'sections/np_analytics_chart_area_section.dart';
import 'sections/np_analytics_export_actions_section.dart';


class NursePractitionerNpAnalyticsScreen extends ConsumerWidget {
  const NursePractitionerNpAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(np_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Nurse Practitioner (NP) Analytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(np_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('np_analytics_loading'), child: Semantics(label: 'np_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('np_analytics_screen'),
                    child: Column(
                      children: [
                        NpAnalyticsHeaderSection(data: state.data),
                        NpAnalyticsFilterBarSection(data: state.data),
                        NpAnalyticsMetricsSummarySection(data: state.data),
                        NpAnalyticsChartAreaSection(data: state.data),
                        NpAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

typedef NursePractitionerNPAnalyticsScreen = NursePractitionerNpAnalyticsScreen;
