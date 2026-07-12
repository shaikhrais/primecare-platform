import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rpn_reports_screen_controller.dart';
import 'sections/rpn_reports_header_section.dart';
import 'sections/rpn_reports_filter_bar_section.dart';
import 'sections/rpn_reports_metrics_summary_section.dart';
import 'sections/rpn_reports_chart_area_section.dart';
import 'sections/rpn_reports_export_actions_section.dart';


class RpnReportsScreen extends ConsumerWidget {
  const RpnReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rpn_reportsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RpnReports'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rpn_reportsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rpn_reports_loading'), child: Semantics(label: 'rpn_reports_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rpn_reports_screen'),
                    child: Column(
                      children: [
                        RpnReportsHeaderSection(data: state.data),
                        RpnReportsFilterBarSection(data: state.data),
                        RpnReportsMetricsSummarySection(data: state.data),
                        RpnReportsChartAreaSection(data: state.data),
                        RpnReportsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
