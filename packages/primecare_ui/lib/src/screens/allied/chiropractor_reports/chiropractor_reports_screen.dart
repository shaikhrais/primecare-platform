import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'chiropractor_reports_screen_controller.dart';
import 'sections/chiropractor_reports_header_section.dart';
import 'sections/chiropractor_reports_filter_bar_section.dart';
import 'sections/chiropractor_reports_metrics_summary_section.dart';
import 'sections/chiropractor_reports_chart_area_section.dart';
import 'sections/chiropractor_reports_export_actions_section.dart';


class ChiropractorReportsScreen extends ConsumerWidget {
  const ChiropractorReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chiropractor_reportsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ChiropractorReports'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(chiropractor_reportsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('chiropractor_reports_loading'), child: Semantics(label: 'chiropractor_reports_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('chiropractor_reports_screen'),
                    child: Column(
                      children: [
                        ChiropractorReportsHeaderSection(data: state.data),
                        ChiropractorReportsFilterBarSection(data: state.data),
                        ChiropractorReportsMetricsSummarySection(data: state.data),
                        ChiropractorReportsChartAreaSection(data: state.data),
                        ChiropractorReportsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
