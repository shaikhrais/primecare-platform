import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'community_outreach_dashboard_screen_controller.dart';
import 'sections/community_outreach_dashboard_header_section.dart';
import 'sections/community_outreach_dashboard_summary_cards_section.dart';
import 'sections/community_outreach_dashboard_chart_overview_section.dart';
import 'sections/community_outreach_dashboard_recent_activity_section.dart';
import 'sections/community_outreach_dashboard_quick_actions_section.dart';


class CommunityOutreachDashboardScreen extends ConsumerWidget {
  const CommunityOutreachDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(community_outreach_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CommunityOutreachDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(community_outreach_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('community_outreach_dashboard_loading'), child: Semantics(label: 'community_outreach_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('community_outreach_dashboard_screen'),
                    child: Column(
                      children: [
                        CommunityOutreachDashboardHeaderSection(data: state.data),
                        CommunityOutreachDashboardSummaryCardsSection(data: state.data),
                        CommunityOutreachDashboardChartOverviewSection(data: state.data),
                        CommunityOutreachDashboardRecentActivitySection(data: state.data),
                        CommunityOutreachDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
