import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rn_dashboard_screen_controller.dart';
import 'sections/rn_dashboard_header_section.dart';
import 'sections/rn_dashboard_summary_cards_section.dart';
import 'sections/rn_dashboard_chart_overview_section.dart';
import 'sections/rn_dashboard_recent_activity_section.dart';
import 'sections/rn_dashboard_quick_actions_section.dart';


class RnDashboardScreen extends ConsumerWidget {
  const RnDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rn_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RnDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rn_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rn_dashboard_loading'), child: Semantics(label: 'rn_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rn_dashboard_screen'),
                    child: Column(
                      children: [
                        RnDashboardHeaderSection(data: state.data),
                        RnDashboardSummaryCardsSection(data: state.data),
                        RnDashboardChartOverviewSection(data: state.data),
                        RnDashboardRecentActivitySection(data: state.data),
                        RnDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
