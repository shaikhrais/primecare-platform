import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'partnership_manager_dashboard_screen_controller.dart';
import 'sections/partnership_manager_dashboard_header_section.dart';
import 'sections/partnership_manager_dashboard_summary_cards_section.dart';
import 'sections/partnership_manager_dashboard_chart_overview_section.dart';
import 'sections/partnership_manager_dashboard_recent_activity_section.dart';
import 'sections/partnership_manager_dashboard_quick_actions_section.dart';


class PartnershipManagerDashboardScreen extends ConsumerWidget {
  const PartnershipManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(partnership_manager_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PartnershipManagerDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(partnership_manager_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('partnership_manager_dashboard_loading'), child: Semantics(label: 'partnership_manager_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('partnership_manager_dashboard_screen'),
                    child: Column(
                      children: [
                        PartnershipManagerDashboardHeaderSection(data: state.data),
                        PartnershipManagerDashboardSummaryCardsSection(data: state.data),
                        PartnershipManagerDashboardChartOverviewSection(data: state.data),
                        PartnershipManagerDashboardRecentActivitySection(data: state.data),
                        PartnershipManagerDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
