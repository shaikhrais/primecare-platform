import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'general_manager_dashboard_screen_controller.dart';
import 'sections/general_manager_dashboard_header_section.dart';
import 'sections/general_manager_dashboard_summary_cards_section.dart';
import 'sections/general_manager_dashboard_chart_overview_section.dart';
import 'sections/general_manager_dashboard_recent_activity_section.dart';
import 'sections/general_manager_dashboard_quick_actions_section.dart';


class GeneralManagerDashboardScreen extends ConsumerWidget {
  const GeneralManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(general_manager_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('GeneralManagerDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(general_manager_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('general_manager_dashboard_loading'), child: Semantics(label: 'general_manager_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('general_manager_dashboard_screen'),
                    child: Column(
                      children: [
                        GeneralManagerDashboardHeaderSection(data: state.data),
                        GeneralManagerDashboardSummaryCardsSection(data: state.data),
                        GeneralManagerDashboardChartOverviewSection(data: state.data),
                        GeneralManagerDashboardRecentActivitySection(data: state.data),
                        GeneralManagerDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
