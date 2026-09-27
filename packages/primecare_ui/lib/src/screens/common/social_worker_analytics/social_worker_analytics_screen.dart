import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'social_worker_analytics_screen_controller.dart';
import 'sections/social_worker_analytics_header_section.dart';
import 'sections/social_worker_analytics_filter_bar_section.dart';
import 'sections/social_worker_analytics_metrics_summary_section.dart';
import 'sections/social_worker_analytics_chart_area_section.dart';
import 'sections/social_worker_analytics_export_actions_section.dart';


class SocialWorkerAnalyticsScreen extends ConsumerWidget {
  const SocialWorkerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(social_worker_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SocialWorkerAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(social_worker_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('social_worker_analytics_loading'), child: Semantics(label: 'social_worker_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('social_worker_analytics_screen'),
                    child: Column(
                      children: [
                        SocialWorkerAnalyticsHeaderSection(data: state.data),
                        SocialWorkerAnalyticsFilterBarSection(data: state.data),
                        SocialWorkerAnalyticsMetricsSummarySection(data: state.data),
                        SocialWorkerAnalyticsChartAreaSection(data: state.data),
                        SocialWorkerAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
