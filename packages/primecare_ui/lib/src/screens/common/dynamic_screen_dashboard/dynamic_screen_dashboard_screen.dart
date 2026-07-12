import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dynamic_screen_dashboard_screen_controller.dart';
import 'sections/dynamic_dashboard_header_section.dart';
import 'sections/dynamic_dashboard_summary_cards_section.dart';
import 'sections/dynamic_dashboard_chart_overview_section.dart';
import 'sections/dynamic_dashboard_recent_activity_section.dart';
import 'sections/dynamic_dashboard_quick_actions_section.dart';


class DynamicDashboardScreen extends ConsumerWidget {
  const DynamicDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dynamic_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Dynamic Dashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(dynamic_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('dynamic_dashboard_loading'), child: Semantics(label: 'dynamic_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('dynamic_dashboard_screen'),
                    child: Column(
                      children: [
                        DynamicDashboardHeaderSection(data: state.data),
                        DynamicDashboardSummaryCardsSection(data: state.data),
                        DynamicDashboardChartOverviewSection(data: state.data),
                        DynamicDashboardRecentActivitySection(data: state.data),
                        DynamicDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
