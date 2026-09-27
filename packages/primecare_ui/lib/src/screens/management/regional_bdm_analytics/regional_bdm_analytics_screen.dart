import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'regional_bdm_analytics_screen_controller.dart';
import 'sections/regional_bdm_analytics_header_section.dart';
import 'sections/regional_bdm_analytics_filter_bar_section.dart';
import 'sections/regional_bdm_analytics_metrics_summary_section.dart';
import 'sections/regional_bdm_analytics_chart_area_section.dart';
import 'sections/regional_bdm_analytics_export_actions_section.dart';


class RegionalBdmAnalyticsScreen extends ConsumerWidget {
  const RegionalBdmAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(regional_bdm_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RegionalBdmAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(regional_bdm_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('regional_bdm_analytics_loading'), child: Semantics(label: 'regional_bdm_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('regional_bdm_analytics_screen'),
                    child: Column(
                      children: [
                        RegionalBdmAnalyticsHeaderSection(data: state.data),
                        RegionalBdmAnalyticsFilterBarSection(data: state.data),
                        RegionalBdmAnalyticsMetricsSummarySection(data: state.data),
                        RegionalBdmAnalyticsChartAreaSection(data: state.data),
                        RegionalBdmAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
