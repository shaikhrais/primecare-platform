import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'community_outreach_analytics_screen_controller.dart';
import 'sections/community_outreach_analytics_header_section.dart';
import 'sections/community_outreach_analytics_filter_bar_section.dart';
import 'sections/community_outreach_analytics_metrics_summary_section.dart';
import 'sections/community_outreach_analytics_chart_area_section.dart';
import 'sections/community_outreach_analytics_export_actions_section.dart';


class CommunityOutreachAnalyticsScreen extends ConsumerWidget {
  const CommunityOutreachAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(community_outreach_analyticsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CommunityOutreachAnalytics'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(community_outreach_analyticsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('community_outreach_analytics_loading'), child: Semantics(label: 'community_outreach_analytics_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('community_outreach_analytics_screen'),
                    child: Column(
                      children: [
                        CommunityOutreachAnalyticsHeaderSection(data: state.data),
                        CommunityOutreachAnalyticsFilterBarSection(data: state.data),
                        CommunityOutreachAnalyticsMetricsSummarySection(data: state.data),
                        CommunityOutreachAnalyticsChartAreaSection(data: state.data),
                        CommunityOutreachAnalyticsExportActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
