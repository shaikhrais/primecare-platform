import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'clinic_analytics_screen_controller.dart';
import 'sections/clinic_analytics_header_section.dart';
import 'sections/clinic_analytics_filter_bar_section.dart';
import 'sections/clinic_analytics_metrics_summary_section.dart';
import 'sections/clinic_analytics_chart_area_section.dart';
import 'sections/clinic_analytics_export_actions_section.dart';


class ClinicAnalyticsScreen extends ConsumerWidget {
  const ClinicAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinic_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ClinicAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(clinic_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('clinic_analytics_loading'), child: Semantics(label: 'clinic_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('clinic_analytics_screen'),
                    child: Column(
                      children: [
                        ClinicAnalyticsHeaderSection(data: state.data),
                        ClinicAnalyticsFilterBarSection(data: state.data),
                        ClinicAnalyticsMetricsSummarySection(data: state.data),
                        ClinicAnalyticsChartAreaSection(data: state.data),
                        ClinicAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
