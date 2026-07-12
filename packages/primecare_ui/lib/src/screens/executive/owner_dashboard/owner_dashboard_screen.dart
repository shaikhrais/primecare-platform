import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'owner_dashboard_screen_controller.dart';
import 'sections/owner_dashboard_header_section.dart';
import 'sections/owner_dashboard_summary_cards_section.dart';
import 'sections/owner_dashboard_chart_overview_section.dart';
import 'sections/owner_dashboard_recent_activity_section.dart';
import 'sections/owner_dashboard_quick_actions_section.dart';


class OwnerDashboardScreen extends ConsumerWidget {
  const OwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(owner_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('OwnerDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(owner_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('owner_dashboard_loading'), child: Semantics(label: 'owner_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('owner_dashboard_screen'),
                    child: Column(
                      children: [
                        OwnerDashboardHeaderSection(data: state.data),
                        OwnerDashboardSummaryCardsSection(data: state.data),
                        OwnerDashboardChartOverviewSection(data: state.data),
                        OwnerDashboardRecentActivitySection(data: state.data),
                        OwnerDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
