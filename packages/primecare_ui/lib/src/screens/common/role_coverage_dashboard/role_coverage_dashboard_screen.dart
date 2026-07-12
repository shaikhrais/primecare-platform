import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'role_coverage_dashboard_screen_controller.dart';
import 'sections/role_coverage_dashboard_header_section.dart';
import 'sections/role_coverage_dashboard_summary_cards_section.dart';
import 'sections/role_coverage_dashboard_chart_overview_section.dart';
import 'sections/role_coverage_dashboard_recent_activity_section.dart';
import 'sections/role_coverage_dashboard_quick_actions_section.dart';


class RoleCoverageDashboardScreen extends ConsumerWidget {
  const RoleCoverageDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(role_coverage_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RoleCoverageDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(role_coverage_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('role_coverage_dashboard_loading'), child: Semantics(label: 'role_coverage_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('role_coverage_dashboard_screen'),
                    child: Column(
                      children: [
                        RoleCoverageDashboardHeaderSection(data: state.data),
                        RoleCoverageDashboardSummaryCardsSection(data: state.data),
                        RoleCoverageDashboardChartOverviewSection(data: state.data),
                        RoleCoverageDashboardRecentActivitySection(data: state.data),
                        RoleCoverageDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
