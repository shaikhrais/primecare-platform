import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'receptionist_analytics_screen_controller.dart';
import 'sections/receptionist_analytics_header_section.dart';
import 'sections/receptionist_analytics_filter_bar_section.dart';
import 'sections/receptionist_analytics_metrics_summary_section.dart';
import 'sections/receptionist_analytics_chart_area_section.dart';
import 'sections/receptionist_analytics_export_actions_section.dart';


class ReceptionistAnalyticsScreen extends ConsumerWidget {
  const ReceptionistAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(receptionist_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ReceptionistAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(receptionist_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('receptionist_analytics_loading'), child: Semantics(label: 'receptionist_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('receptionist_analytics_screen'),
                    child: Column(
                      children: [
                        ReceptionistAnalyticsHeaderSection(data: state.data),
                        ReceptionistAnalyticsFilterBarSection(data: state.data),
                        ReceptionistAnalyticsMetricsSummarySection(data: state.data),
                        ReceptionistAnalyticsChartAreaSection(data: state.data),
                        ReceptionistAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
