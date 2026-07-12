import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'scheduling_dashboard_screen_controller.dart';
import 'sections/scheduling_dashboard_header_section.dart';
import 'sections/scheduling_dashboard_summary_cards_section.dart';
import 'sections/scheduling_dashboard_chart_overview_section.dart';
import 'sections/scheduling_dashboard_recent_activity_section.dart';
import 'sections/scheduling_dashboard_quick_actions_section.dart';


class SchedulingDashboardScreen extends ConsumerWidget {
  const SchedulingDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduling_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SchedulingDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(scheduling_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('scheduling_dashboard_loading'), child: Semantics(label: 'scheduling_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('scheduling_dashboard_screen'),
                    child: Column(
                      children: [
                        SchedulingDashboardHeaderSection(data: state.data),
                        SchedulingDashboardSummaryCardsSection(data: state.data),
                        SchedulingDashboardChartOverviewSection(data: state.data),
                        SchedulingDashboardRecentActivitySection(data: state.data),
                        SchedulingDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
