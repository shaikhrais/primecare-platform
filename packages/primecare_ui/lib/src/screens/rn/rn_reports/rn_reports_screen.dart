import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rn_reports_screen_controller.dart';
import 'sections/rn_reports_header_section.dart';
import 'sections/rn_reports_filter_bar_section.dart';
import 'sections/rn_reports_metrics_summary_section.dart';
import 'sections/rn_reports_chart_area_section.dart';
import 'sections/rn_reports_export_actions_section.dart';


class RnReportsScreen extends ConsumerWidget {
  const RnReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rn_reportsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RnReports'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rn_reportsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rn_reports_loading'), child: Semantics(label: 'rn_reports_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rn_reports_screen'),
                    child: Column(
                      children: [
                        RnReportsHeaderSection(data: state.data),
                        RnReportsFilterBarSection(data: state.data),
                        RnReportsMetricsSummarySection(data: state.data),
                        RnReportsChartAreaSection(data: state.data),
                        RnReportsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
