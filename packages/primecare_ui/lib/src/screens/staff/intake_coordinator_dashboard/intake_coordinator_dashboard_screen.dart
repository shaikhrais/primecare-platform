import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'intake_coordinator_dashboard_screen_controller.dart';
import 'sections/intake_coordinator_dashboard_header_section.dart';
import 'sections/intake_coordinator_dashboard_summary_cards_section.dart';
import 'sections/intake_coordinator_dashboard_chart_overview_section.dart';
import 'sections/intake_coordinator_dashboard_recent_activity_section.dart';
import 'sections/intake_coordinator_dashboard_quick_actions_section.dart';


class IntakeCoordinatorDashboardScreen extends ConsumerWidget {
  const IntakeCoordinatorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(intake_coordinator_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('IntakeCoordinatorDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(intake_coordinator_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('intake_coordinator_dashboard_loading'), child: Semantics(label: 'intake_coordinator_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('intake_coordinator_dashboard_screen'),
                    child: Column(
                      children: [
                        IntakeCoordinatorDashboardHeaderSection(data: state.data),
                        IntakeCoordinatorDashboardSummaryCardsSection(data: state.data),
                        IntakeCoordinatorDashboardChartOverviewSection(data: state.data),
                        IntakeCoordinatorDashboardRecentActivitySection(data: state.data),
                        IntakeCoordinatorDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
