import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'lpn_dashboard_controller.dart';
import 'sections/lpn_dashboard_header_section.dart';
import 'sections/lpn_dashboard_summary_cards_section.dart';
import 'sections/lpn_dashboard_chart_overview_section.dart';
import 'sections/lpn_dashboard_recent_activity_section.dart';
import 'sections/lpn_dashboard_quick_actions_section.dart';

class LpnDashboardScreen extends ConsumerWidget {
  const LpnDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(lpnDashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('LPN Clinical Dashboard'),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.sync),
              onPressed: () => ref.read(lpnDashboardControllerProvider.notifier).syncData(),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('lpndashboard_loading'), child: CircularProgressIndicator())
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('lpndashboard_screen'),
                    child: Column(
                      children: [
                        LpnDashboardHeaderSection(data: state.data),
                        LpnDashboardSummaryCardsSection(data: state.data),
                        const LpnDashboardChartOverviewSection(),
                        const LpnDashboardRecentActivitySection(),
                        const LpnDashboardQuickActionsSection(),
                      ],
                    ),
                  ),
      ),
    );
  }
}
