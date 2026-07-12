import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'system_verification_analytics_screen_controller.dart';
import 'sections/system_verification_analytics_header_section.dart';
import 'sections/system_verification_analytics_filter_bar_section.dart';
import 'sections/system_verification_analytics_metrics_summary_section.dart';
import 'sections/system_verification_analytics_chart_area_section.dart';
import 'sections/system_verification_analytics_export_actions_section.dart';


class SystemVerificationAnalyticsScreen extends ConsumerWidget {
  const SystemVerificationAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(system_verification_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SystemVerificationAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(system_verification_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('system_verification_analytics_loading'), child: Semantics(label: 'system_verification_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('system_verification_analytics_screen'),
                    child: Column(
                      children: [
                        SystemVerificationAnalyticsHeaderSection(data: state.data),
                        SystemVerificationAnalyticsFilterBarSection(data: state.data),
                        SystemVerificationAnalyticsMetricsSummarySection(data: state.data),
                        SystemVerificationAnalyticsChartAreaSection(data: state.data),
                        SystemVerificationAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
