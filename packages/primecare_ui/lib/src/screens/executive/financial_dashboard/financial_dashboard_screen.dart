import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'financial_dashboard_screen_controller.dart';
import 'sections/financial_dashboard_header_section.dart';
import 'sections/financial_dashboard_summary_cards_section.dart';
import 'sections/financial_dashboard_chart_overview_section.dart';
import 'sections/financial_dashboard_recent_activity_section.dart';
import 'sections/financial_dashboard_quick_actions_section.dart';


class FinancialDashboardScreen extends ConsumerWidget {
  const FinancialDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(financial_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FinancialDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(financial_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('financial_dashboard_loading'), child: Semantics(label: 'financial_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('financial_dashboard_screen'),
                    child: Column(
                      children: [
                        FinancialDashboardHeaderSection(data: state.data),
                        FinancialDashboardSummaryCardsSection(data: state.data),
                        FinancialDashboardChartOverviewSection(data: state.data),
                        FinancialDashboardRecentActivitySection(data: state.data),
                        FinancialDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
