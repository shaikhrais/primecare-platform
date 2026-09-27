import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'caregiver_incident_report_screen_controller.dart';
import 'sections/caregiver_incident_report_header_section.dart';
import 'sections/caregiver_incident_report_filter_bar_section.dart';
import 'sections/caregiver_incident_report_metrics_summary_section.dart';
import 'sections/caregiver_incident_report_chart_area_section.dart';
import 'sections/caregiver_incident_report_export_actions_section.dart';


class CaregiverIncidentReportScreen extends ConsumerWidget {
  const CaregiverIncidentReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(caregiver_incident_reportControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CaregiverIncidentReport'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(caregiver_incident_reportControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('caregiver_incident_report_loading'), child: Semantics(label: 'caregiver_incident_report_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('caregiver_incident_report_screen'),
                    child: Column(
                      children: [
                        CaregiverIncidentReportHeaderSection(data: state.data),
                        CaregiverIncidentReportFilterBarSection(data: state.data),
                        CaregiverIncidentReportMetricsSummarySection(data: state.data),
                        CaregiverIncidentReportChartAreaSection(data: state.data),
                        CaregiverIncidentReportExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
