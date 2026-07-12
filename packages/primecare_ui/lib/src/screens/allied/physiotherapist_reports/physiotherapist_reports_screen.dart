import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'physiotherapist_reports_screen_controller.dart';
import 'sections/physiotherapist_reports_header_section.dart';
import 'sections/physiotherapist_reports_filter_bar_section.dart';
import 'sections/physiotherapist_reports_metrics_summary_section.dart';
import 'sections/physiotherapist_reports_chart_area_section.dart';
import 'sections/physiotherapist_reports_export_actions_section.dart';


class PhysiotherapistReportsScreen extends ConsumerWidget {
  const PhysiotherapistReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(physiotherapist_reportsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PhysiotherapistReports'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(physiotherapist_reportsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('physiotherapist_reports_loading'), child: Semantics(label: 'physiotherapist_reports_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('physiotherapist_reports_screen'),
                    child: Column(
                      children: [
                        PhysiotherapistReportsHeaderSection(data: state.data),
                        PhysiotherapistReportsFilterBarSection(data: state.data),
                        PhysiotherapistReportsMetricsSummarySection(data: state.data),
                        PhysiotherapistReportsChartAreaSection(data: state.data),
                        PhysiotherapistReportsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
