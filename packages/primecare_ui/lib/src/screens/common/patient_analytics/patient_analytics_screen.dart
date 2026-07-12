import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'patient_analytics_screen_controller.dart';
import 'sections/patient_analytics_header_section.dart';
import 'sections/patient_analytics_filter_bar_section.dart';
import 'sections/patient_analytics_metrics_summary_section.dart';
import 'sections/patient_analytics_chart_area_section.dart';
import 'sections/patient_analytics_export_actions_section.dart';


class PatientAnalyticsScreen extends ConsumerWidget {
  const PatientAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patient_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PatientAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(patient_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('patient_analytics_loading'), child: Semantics(label: 'patient_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('patient_analytics_screen'),
                    child: Column(
                      children: [
                        PatientAnalyticsHeaderSection(data: state.data),
                        PatientAnalyticsFilterBarSection(data: state.data),
                        PatientAnalyticsMetricsSummarySection(data: state.data),
                        PatientAnalyticsChartAreaSection(data: state.data),
                        PatientAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
