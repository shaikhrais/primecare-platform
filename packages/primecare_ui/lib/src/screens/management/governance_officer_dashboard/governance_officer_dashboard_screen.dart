import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'governance_officer_dashboard_screen_controller.dart';
import 'sections/governance_officer_dashboard_header_section.dart';
import 'sections/governance_officer_dashboard_summary_cards_section.dart';
import 'sections/governance_officer_dashboard_chart_overview_section.dart';
import 'sections/governance_officer_dashboard_recent_activity_section.dart';
import 'sections/governance_officer_dashboard_quick_actions_section.dart';


class GovernanceOfficerDashboardScreen extends ConsumerWidget {
  const GovernanceOfficerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(governance_officer_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('GovernanceOfficerDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(governance_officer_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('governance_officer_dashboard_loading'), child: Semantics(label: 'governance_officer_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('governance_officer_dashboard_screen'),
                    child: Column(
                      children: [
                        GovernanceOfficerDashboardHeaderSection(data: state.data),
                        GovernanceOfficerDashboardSummaryCardsSection(data: state.data),
                        GovernanceOfficerDashboardChartOverviewSection(data: state.data),
                        GovernanceOfficerDashboardRecentActivitySection(data: state.data),
                        GovernanceOfficerDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
