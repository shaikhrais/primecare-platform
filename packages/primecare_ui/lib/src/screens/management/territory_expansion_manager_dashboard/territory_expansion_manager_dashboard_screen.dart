import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'territory_expansion_manager_dashboard_screen_controller.dart';
import 'sections/territory_expansion_manager_dashboard_header_section.dart';
import 'sections/territory_expansion_manager_dashboard_summary_cards_section.dart';
import 'sections/territory_expansion_manager_dashboard_chart_overview_section.dart';
import 'sections/territory_expansion_manager_dashboard_recent_activity_section.dart';
import 'sections/territory_expansion_manager_dashboard_quick_actions_section.dart';


class TerritoryExpansionManagerDashboardScreen extends ConsumerWidget {
  const TerritoryExpansionManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(territory_expansion_manager_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('TerritoryExpansionManagerDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(territory_expansion_manager_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('territory_expansion_manager_dashboard_loading'), child: Semantics(label: 'territory_expansion_manager_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('territory_expansion_manager_dashboard_screen'),
                    child: Column(
                      children: [
                        TerritoryExpansionManagerDashboardHeaderSection(data: state.data),
                        TerritoryExpansionManagerDashboardSummaryCardsSection(data: state.data),
                        TerritoryExpansionManagerDashboardChartOverviewSection(data: state.data),
                        TerritoryExpansionManagerDashboardRecentActivitySection(data: state.data),
                        TerritoryExpansionManagerDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
