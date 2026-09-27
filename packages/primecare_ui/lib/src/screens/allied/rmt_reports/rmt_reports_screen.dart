import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rmt_reports_screen_controller.dart';
import 'sections/rmt_reports_header_section.dart';
import 'sections/rmt_reports_filter_bar_section.dart';
import 'sections/rmt_reports_metrics_summary_section.dart';
import 'sections/rmt_reports_chart_area_section.dart';
import 'sections/rmt_reports_export_actions_section.dart';


class RmtReportsScreen extends ConsumerWidget {
  const RmtReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rmt_reportsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RmtReports'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rmt_reportsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rmt_reports_loading'), child: Semantics(label: 'rmt_reports_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rmt_reports_screen'),
                    child: Column(
                      children: [
                        RmtReportsHeaderSection(data: state.data),
                        RmtReportsFilterBarSection(data: state.data),
                        RmtReportsMetricsSummarySection(data: state.data),
                        RmtReportsChartAreaSection(data: state.data),
                        RmtReportsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
