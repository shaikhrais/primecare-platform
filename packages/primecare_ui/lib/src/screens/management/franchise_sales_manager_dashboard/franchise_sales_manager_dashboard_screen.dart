import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'franchise_sales_manager_dashboard_screen_controller.dart';
import 'sections/franchise_sales_manager_dashboard_header_section.dart';
import 'sections/franchise_sales_manager_dashboard_summary_cards_section.dart';
import 'sections/franchise_sales_manager_dashboard_chart_overview_section.dart';
import 'sections/franchise_sales_manager_dashboard_recent_activity_section.dart';
import 'sections/franchise_sales_manager_dashboard_quick_actions_section.dart';


class FranchiseSalesManagerDashboardScreen extends ConsumerWidget {
  const FranchiseSalesManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(franchise_sales_manager_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FranchiseSalesManagerDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(franchise_sales_manager_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('franchise_sales_manager_dashboard_loading'), child: Semantics(label: 'franchise_sales_manager_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('franchise_sales_manager_dashboard_screen'),
                    child: Column(
                      children: [
                        FranchiseSalesManagerDashboardHeaderSection(data: state.data),
                        FranchiseSalesManagerDashboardSummaryCardsSection(data: state.data),
                        FranchiseSalesManagerDashboardChartOverviewSection(data: state.data),
                        FranchiseSalesManagerDashboardRecentActivitySection(data: state.data),
                        FranchiseSalesManagerDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
