import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'volunteer_dashboard_screen_controller.dart';
import 'sections/volunteer_dashboard_header_section.dart';
import 'sections/volunteer_dashboard_summary_cards_section.dart';
import 'sections/volunteer_dashboard_chart_overview_section.dart';
import 'sections/volunteer_dashboard_recent_activity_section.dart';
import 'sections/volunteer_dashboard_quick_actions_section.dart';


class VolunteerDashboardScreen extends ConsumerWidget {
  const VolunteerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(volunteer_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('VolunteerDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(volunteer_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('volunteer_dashboard_loading'), child: Semantics(label: 'volunteer_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('volunteer_dashboard_screen'),
                    child: Column(
                      children: [
                        VolunteerDashboardHeaderSection(data: state.data),
                        VolunteerDashboardSummaryCardsSection(data: state.data),
                        VolunteerDashboardChartOverviewSection(data: state.data),
                        VolunteerDashboardRecentActivitySection(data: state.data),
                        VolunteerDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
