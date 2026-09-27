import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'premium_concierge_dashboard_screen_controller.dart';
import 'sections/premium_concierge_dashboard_header_section.dart';
import 'sections/premium_concierge_dashboard_summary_cards_section.dart';
import 'sections/premium_concierge_dashboard_chart_overview_section.dart';
import 'sections/premium_concierge_dashboard_recent_activity_section.dart';
import 'sections/premium_concierge_dashboard_quick_actions_section.dart';


class PremiumConciergeDashboardScreen extends ConsumerWidget {
  const PremiumConciergeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(premium_concierge_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PremiumConciergeDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(premium_concierge_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('premium_concierge_dashboard_loading'), child: Semantics(label: 'premium_concierge_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('premium_concierge_dashboard_screen'),
                    child: Column(
                      children: [
                        PremiumConciergeDashboardHeaderSection(data: state.data),
                        PremiumConciergeDashboardSummaryCardsSection(data: state.data),
                        PremiumConciergeDashboardChartOverviewSection(data: state.data),
                        PremiumConciergeDashboardRecentActivitySection(data: state.data),
                        PremiumConciergeDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
