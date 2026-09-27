import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'volunteer_coordinator_dashboard_screen_controller.dart';
import 'sections/volunteer_coordinator_dashboard_header_section.dart';
import 'sections/volunteer_coordinator_dashboard_summary_cards_section.dart';
import 'sections/volunteer_coordinator_dashboard_chart_overview_section.dart';
import 'sections/volunteer_coordinator_dashboard_recent_activity_section.dart';
import 'sections/volunteer_coordinator_dashboard_quick_actions_section.dart';


class VolunteerCoordinatorDashboardScreen extends ConsumerWidget {
  const VolunteerCoordinatorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(volunteer_coordinator_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('VolunteerCoordinatorDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(volunteer_coordinator_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('volunteer_coordinator_dashboard_loading'), child: Semantics(label: 'volunteer_coordinator_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('volunteer_coordinator_dashboard_screen'),
                    child: Column(
                      children: [
                        VolunteerCoordinatorDashboardHeaderSection(data: state.data),
                        VolunteerCoordinatorDashboardSummaryCardsSection(data: state.data),
                        VolunteerCoordinatorDashboardChartOverviewSection(data: state.data),
                        VolunteerCoordinatorDashboardRecentActivitySection(data: state.data),
                        VolunteerCoordinatorDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
