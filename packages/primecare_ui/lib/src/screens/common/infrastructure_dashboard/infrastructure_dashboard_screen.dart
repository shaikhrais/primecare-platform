import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'infrastructure_dashboard_screen_controller.dart';
import 'sections/infrastructure_dashboard_header_section.dart';
import 'sections/infrastructure_dashboard_summary_cards_section.dart';
import 'sections/infrastructure_dashboard_chart_overview_section.dart';
import 'sections/infrastructure_dashboard_recent_activity_section.dart';
import 'sections/infrastructure_dashboard_quick_actions_section.dart';


class InfrastructureDashboardScreen extends ConsumerWidget {
  const InfrastructureDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(infrastructure_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('InfrastructureDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(infrastructure_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('infrastructure_dashboard_loading'), child: Semantics(label: 'infrastructure_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('infrastructure_dashboard_screen'),
                    child: Column(
                      children: [
                        InfrastructureDashboardHeaderSection(data: state.data),
                        InfrastructureDashboardSummaryCardsSection(data: state.data),
                        InfrastructureDashboardChartOverviewSection(data: state.data),
                        InfrastructureDashboardRecentActivitySection(data: state.data),
                        InfrastructureDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
