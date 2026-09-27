import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'hsw_incident_reports_screen_controller.dart';
import 'sections/hsw_incident_reports_header_section.dart';
import 'sections/hsw_incident_reports_filter_bar_section.dart';
import 'sections/hsw_incident_reports_metrics_summary_section.dart';
import 'sections/hsw_incident_reports_chart_area_section.dart';
import 'sections/hsw_incident_reports_export_actions_section.dart';


class HswIncidentReportsScreen extends ConsumerWidget {
  const HswIncidentReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hsw_incident_reportsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HswIncidentReports'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(hsw_incident_reportsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('hsw_incident_reports_loading'), child: Semantics(label: 'hsw_incident_reports_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('hsw_incident_reports_screen'),
                    child: Column(
                      children: [
                        HswIncidentReportsHeaderSection(data: state.data),
                        HswIncidentReportsFilterBarSection(data: state.data),
                        HswIncidentReportsMetricsSummarySection(data: state.data),
                        HswIncidentReportsChartAreaSection(data: state.data),
                        HswIncidentReportsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
