import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'shift_report_screen_controller.dart';
import 'sections/shift_report_header_section.dart';
import 'sections/shift_report_filter_bar_section.dart';
import 'sections/shift_report_metrics_summary_section.dart';
import 'sections/shift_report_chart_area_section.dart';
import 'sections/shift_report_export_actions_section.dart';


class ShiftReportScreen extends ConsumerWidget {
  const ShiftReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(shift_reportControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ShiftReport'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(shift_reportControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('shift_report_loading'), child: Semantics(label: 'shift_report_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('shift_report_screen'),
                    child: Column(
                      children: [
                        ShiftReportHeaderSection(data: state.data),
                        ShiftReportFilterBarSection(data: state.data),
                        ShiftReportMetricsSummarySection(data: state.data),
                        ShiftReportChartAreaSection(data: state.data),
                        ShiftReportExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
