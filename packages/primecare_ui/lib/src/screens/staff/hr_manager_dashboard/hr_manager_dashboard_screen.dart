import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'hr_manager_dashboard_screen_controller.dart';
import 'sections/hr_manager_dashboard_header_section.dart';
import 'sections/hr_manager_dashboard_summary_cards_section.dart';
import 'sections/hr_manager_dashboard_chart_overview_section.dart';
import 'sections/hr_manager_dashboard_recent_activity_section.dart';
import 'sections/hr_manager_dashboard_quick_actions_section.dart';


class HrManagerDashboardScreen extends ConsumerWidget {
  const HrManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hr_manager_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HrManagerDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(hr_manager_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('hr_manager_dashboard_loading'), child: Semantics(label: 'hr_manager_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('hr_manager_dashboard_screen'),
                    child: Column(
                      children: [
                        HrManagerDashboardHeaderSection(data: state.data),
                        HrManagerDashboardSummaryCardsSection(data: state.data),
                        HrManagerDashboardChartOverviewSection(data: state.data),
                        HrManagerDashboardRecentActivitySection(data: state.data),
                        HrManagerDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
