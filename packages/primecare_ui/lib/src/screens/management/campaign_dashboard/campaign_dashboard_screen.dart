import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'campaign_dashboard_screen_controller.dart';
import 'sections/campaign_dashboard_header_section.dart';
import 'sections/campaign_dashboard_summary_cards_section.dart';
import 'sections/campaign_dashboard_chart_overview_section.dart';
import 'sections/campaign_dashboard_recent_activity_section.dart';
import 'sections/campaign_dashboard_quick_actions_section.dart';


class CampaignDashboardScreen extends ConsumerWidget {
  const CampaignDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(campaign_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CampaignDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(campaign_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('campaign_dashboard_loading'), child: Semantics(label: 'campaign_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('campaign_dashboard_screen'),
                    child: Column(
                      children: [
                        CampaignDashboardHeaderSection(data: state.data),
                        CampaignDashboardSummaryCardsSection(data: state.data),
                        CampaignDashboardChartOverviewSection(data: state.data),
                        CampaignDashboardRecentActivitySection(data: state.data),
                        CampaignDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
