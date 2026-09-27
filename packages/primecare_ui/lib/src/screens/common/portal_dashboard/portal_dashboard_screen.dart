import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'portal_dashboard_screen_controller.dart';
import 'sections/portal_dashboard_header_section.dart';
import 'sections/portal_dashboard_summary_cards_section.dart';
import 'sections/portal_dashboard_chart_overview_section.dart';
import 'sections/portal_dashboard_recent_activity_section.dart';
import 'sections/portal_dashboard_quick_actions_section.dart';


class PortalDashboardScreen extends ConsumerWidget {
  const PortalDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(portal_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PortalDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(portal_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('portal_dashboard_loading'), child: Semantics(label: 'portal_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('portal_dashboard_screen'),
                    child: Column(
                      children: [
                        PortalDashboardHeaderSection(data: state.data),
                        PortalDashboardSummaryCardsSection(data: state.data),
                        PortalDashboardChartOverviewSection(data: state.data),
                        PortalDashboardRecentActivitySection(data: state.data),
                        PortalDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
