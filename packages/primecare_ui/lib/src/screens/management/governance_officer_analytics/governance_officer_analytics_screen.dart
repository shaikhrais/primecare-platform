import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'governance_officer_analytics_screen_controller.dart';
import 'sections/governance_officer_analytics_header_section.dart';
import 'sections/governance_officer_analytics_filter_bar_section.dart';
import 'sections/governance_officer_analytics_metrics_summary_section.dart';
import 'sections/governance_officer_analytics_chart_area_section.dart';
import 'sections/governance_officer_analytics_export_actions_section.dart';


class GovernanceOfficerAnalyticsScreen extends ConsumerWidget {
  const GovernanceOfficerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(governance_officer_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('GovernanceOfficerAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(governance_officer_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('governance_officer_analytics_loading'), child: Semantics(label: 'governance_officer_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('governance_officer_analytics_screen'),
                    child: Column(
                      children: [
                        GovernanceOfficerAnalyticsHeaderSection(data: state.data),
                        GovernanceOfficerAnalyticsFilterBarSection(data: state.data),
                        GovernanceOfficerAnalyticsMetricsSummarySection(data: state.data),
                        GovernanceOfficerAnalyticsChartAreaSection(data: state.data),
                        GovernanceOfficerAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
