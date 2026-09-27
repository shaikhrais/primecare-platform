import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rpn_dashboard_screen_controller.dart';
import 'sections/rpn_dashboard_header_section.dart';
import 'sections/rpn_dashboard_summary_cards_section.dart';
import 'sections/rpn_dashboard_chart_overview_section.dart';
import 'sections/rpn_dashboard_recent_activity_section.dart';
import 'sections/rpn_dashboard_quick_actions_section.dart';


class RpnDashboardScreen extends ConsumerWidget {
  const RpnDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rpn_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RpnDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rpn_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rpn_dashboard_loading'), child: Semantics(label: 'rpn_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rpn_dashboard_screen'),
                    child: Column(
                      children: [
                        RpnDashboardHeaderSection(data: state.data),
                        RpnDashboardSummaryCardsSection(data: state.data),
                        RpnDashboardChartOverviewSection(data: state.data),
                        RpnDashboardRecentActivitySection(data: state.data),
                        RpnDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
