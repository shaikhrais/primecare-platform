import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'compliance_manager_analytics_screen_controller.dart';
import 'sections/compliance_manager_analytics_header_section.dart';
import 'sections/compliance_manager_analytics_filter_bar_section.dart';
import 'sections/compliance_manager_analytics_metrics_summary_section.dart';
import 'sections/compliance_manager_analytics_chart_area_section.dart';
import 'sections/compliance_manager_analytics_export_actions_section.dart';


class ComplianceManagerAnalyticsScreen extends ConsumerWidget {
  const ComplianceManagerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(compliance_manager_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ComplianceManagerAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(compliance_manager_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('compliance_manager_analytics_loading'), child: Semantics(label: 'compliance_manager_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('compliance_manager_analytics_screen'),
                    child: Column(
                      children: [
                        ComplianceManagerAnalyticsHeaderSection(data: state.data),
                        ComplianceManagerAnalyticsFilterBarSection(data: state.data),
                        ComplianceManagerAnalyticsMetricsSummarySection(data: state.data),
                        ComplianceManagerAnalyticsChartAreaSection(data: state.data),
                        ComplianceManagerAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
