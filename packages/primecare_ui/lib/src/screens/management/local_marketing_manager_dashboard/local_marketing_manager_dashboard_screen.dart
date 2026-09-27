import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'local_marketing_manager_dashboard_screen_controller.dart';
import 'sections/local_marketing_manager_dashboard_header_section.dart';
import 'sections/local_marketing_manager_dashboard_summary_cards_section.dart';
import 'sections/local_marketing_manager_dashboard_chart_overview_section.dart';
import 'sections/local_marketing_manager_dashboard_recent_activity_section.dart';
import 'sections/local_marketing_manager_dashboard_quick_actions_section.dart';


class LocalMarketingManagerDashboardScreen extends ConsumerWidget {
  const LocalMarketingManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(local_marketing_manager_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('LocalMarketingManagerDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(local_marketing_manager_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('local_marketing_manager_dashboard_loading'), child: Semantics(label: 'local_marketing_manager_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('local_marketing_manager_dashboard_screen'),
                    child: Column(
                      children: [
                        LocalMarketingManagerDashboardHeaderSection(data: state.data),
                        LocalMarketingManagerDashboardSummaryCardsSection(data: state.data),
                        LocalMarketingManagerDashboardChartOverviewSection(data: state.data),
                        LocalMarketingManagerDashboardRecentActivitySection(data: state.data),
                        LocalMarketingManagerDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
