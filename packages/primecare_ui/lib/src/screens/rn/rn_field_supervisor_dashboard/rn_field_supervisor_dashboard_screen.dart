import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rn_field_supervisor_dashboard_screen_controller.dart';
import 'sections/rn_field_supervisor_dashboard_header_section.dart';
import 'sections/rn_field_supervisor_dashboard_summary_cards_section.dart';
import 'sections/rn_field_supervisor_dashboard_chart_overview_section.dart';
import 'sections/rn_field_supervisor_dashboard_recent_activity_section.dart';
import 'sections/rn_field_supervisor_dashboard_quick_actions_section.dart';


class RnFieldSupervisorDashboardScreen extends ConsumerWidget {
  const RnFieldSupervisorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rn_field_supervisor_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RnFieldSupervisorDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rn_field_supervisor_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rn_field_supervisor_dashboard_loading'), child: Semantics(label: 'rn_field_supervisor_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rn_field_supervisor_dashboard_screen'),
                    child: Column(
                      children: [
                        RnFieldSupervisorDashboardHeaderSection(data: state.data),
                        RnFieldSupervisorDashboardSummaryCardsSection(data: state.data),
                        RnFieldSupervisorDashboardChartOverviewSection(data: state.data),
                        RnFieldSupervisorDashboardRecentActivitySection(data: state.data),
                        RnFieldSupervisorDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
