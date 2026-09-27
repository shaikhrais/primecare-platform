import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'pediatric_analytics_screen_controller.dart';
import 'sections/pediatric_analytics_header_section.dart';
import 'sections/pediatric_analytics_filter_bar_section.dart';
import 'sections/pediatric_analytics_metrics_summary_section.dart';
import 'sections/pediatric_analytics_chart_area_section.dart';
import 'sections/pediatric_analytics_export_actions_section.dart';


class PediatricSpecialistAnalyticsScreen extends ConsumerWidget {
  const PediatricSpecialistAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pediatric_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Pediatric Specialist Analytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(pediatric_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('pediatric_analytics_loading'), child: Semantics(label: 'pediatric_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('pediatric_analytics_screen'),
                    child: Column(
                      children: [
                        PediatricAnalyticsHeaderSection(data: state.data),
                        PediatricAnalyticsFilterBarSection(data: state.data),
                        PediatricAnalyticsMetricsSummarySection(data: state.data),
                        PediatricAnalyticsChartAreaSection(data: state.data),
                        PediatricAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
