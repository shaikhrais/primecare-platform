import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'regional_bdm_dashboard_screen_controller.dart';
import 'sections/regional_bdm_dashboard_header_section.dart';
import 'sections/regional_bdm_dashboard_summary_cards_section.dart';
import 'sections/regional_bdm_dashboard_chart_overview_section.dart';
import 'sections/regional_bdm_dashboard_recent_activity_section.dart';
import 'sections/regional_bdm_dashboard_quick_actions_section.dart';


class RegionalBdmDashboardScreen extends ConsumerWidget {
  const RegionalBdmDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(regional_bdm_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RegionalBdmDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(regional_bdm_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('regional_bdm_dashboard_loading'), child: Semantics(label: 'regional_bdm_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('regional_bdm_dashboard_screen'),
                    child: Column(
                      children: [
                        RegionalBdmDashboardHeaderSection(data: state.data),
                        RegionalBdmDashboardSummaryCardsSection(data: state.data),
                        RegionalBdmDashboardChartOverviewSection(data: state.data),
                        RegionalBdmDashboardRecentActivitySection(data: state.data),
                        RegionalBdmDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
