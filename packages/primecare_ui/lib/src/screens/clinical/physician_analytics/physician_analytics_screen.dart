import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'physician_analytics_screen_controller.dart';
import 'sections/physician_analytics_header_section.dart';
import 'sections/physician_analytics_filter_bar_section.dart';
import 'sections/physician_analytics_metrics_summary_section.dart';
import 'sections/physician_analytics_chart_area_section.dart';
import 'sections/physician_analytics_export_actions_section.dart';


class PhysicianAnalyticsScreen extends ConsumerWidget {
  const PhysicianAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(physician_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Physician Analytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(physician_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('physician_analytics_loading'), child: Semantics(label: 'physician_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('physician_analytics_screen'),
                    child: Column(
                      children: [
                        PhysicianAnalyticsHeaderSection(data: state.data),
                        PhysicianAnalyticsFilterBarSection(data: state.data),
                        PhysicianAnalyticsMetricsSummarySection(data: state.data),
                        PhysicianAnalyticsChartAreaSection(data: state.data),
                        PhysicianAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
