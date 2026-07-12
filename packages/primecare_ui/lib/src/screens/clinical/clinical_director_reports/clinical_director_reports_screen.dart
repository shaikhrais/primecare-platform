import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'clinical_director_reports_screen_controller.dart';
import 'sections/clinical_director_reports_header_section.dart';
import 'sections/clinical_director_reports_filter_bar_section.dart';
import 'sections/clinical_director_reports_metrics_summary_section.dart';
import 'sections/clinical_director_reports_chart_area_section.dart';
import 'sections/clinical_director_reports_export_actions_section.dart';


class ClinicalDirectorReportsScreen extends ConsumerWidget {
  const ClinicalDirectorReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinical_director_reportsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ClinicalDirectorReports'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(clinical_director_reportsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('clinical_director_reports_loading'), child: Semantics(label: 'clinical_director_reports_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('clinical_director_reports_screen'),
                    child: Column(
                      children: [
                        ClinicalDirectorReportsHeaderSection(data: state.data),
                        ClinicalDirectorReportsFilterBarSection(data: state.data),
                        ClinicalDirectorReportsMetricsSummarySection(data: state.data),
                        ClinicalDirectorReportsChartAreaSection(data: state.data),
                        ClinicalDirectorReportsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
