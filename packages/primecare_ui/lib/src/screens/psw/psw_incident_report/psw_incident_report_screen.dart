import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'psw_incident_report_screen_controller.dart';
import 'sections/psw_incident_report_header_section.dart';
import 'sections/psw_incident_report_filter_bar_section.dart';
import 'sections/psw_incident_report_metrics_summary_section.dart';
import 'sections/psw_incident_report_chart_area_section.dart';
import 'sections/psw_incident_report_export_actions_section.dart';


class ReportIncidentScreen extends ConsumerWidget {
  const ReportIncidentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(psw_incident_reportControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Report Incident'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(psw_incident_reportControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('psw_incident_report_loading'), child: Semantics(label: 'psw_incident_report_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('psw_incident_report_screen'),
                    child: Column(
                      children: [
                        PswIncidentReportHeaderSection(data: state.data),
                        PswIncidentReportFilterBarSection(data: state.data),
                        PswIncidentReportMetricsSummarySection(data: state.data),
                        PswIncidentReportChartAreaSection(data: state.data),
                        PswIncidentReportExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

typedef PswIncidentReportScreen = ReportIncidentScreen;
