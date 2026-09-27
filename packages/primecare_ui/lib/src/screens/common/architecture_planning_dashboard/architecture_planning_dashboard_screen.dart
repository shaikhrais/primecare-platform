import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'architecture_planning_dashboard_controller.dart';
import 'sections/architecture_planning_dashboard_header_section.dart';
import 'sections/architecture_planning_dashboard_summary_cards_section.dart';
import 'sections/architecture_planning_dashboard_chart_overview_section.dart';
import 'sections/architecture_planning_dashboard_recent_activity_section.dart';
import 'sections/architecture_planning_dashboard_quick_actions_section.dart';

class ArchitecturePlanningDashboardScreen extends ConsumerWidget {
  const ArchitecturePlanningDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(architecturePlanningDashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Architecture Dashboard'),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.sync),
              onPressed: () => ref.read(architecturePlanningDashboardControllerProvider.notifier).syncData(),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('architectureplanningdashboard_loading'), child: CircularProgressIndicator())
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('architectureplanningdashboard_screen'),
                    child: Column(
                      children: [
                        ArchitecturePlanningDashboardHeaderSection(data: state.data),
                        ArchitecturePlanningDashboardSummaryCardsSection(data: state.data),
                        const ArchitecturePlanningDashboardChartOverviewSection(),
                        const ArchitecturePlanningDashboardRecentActivitySection(),
                        const ArchitecturePlanningDashboardQuickActionsSection(),
                      ],
                    ),
                  ),
      ),
    );
  }
}
