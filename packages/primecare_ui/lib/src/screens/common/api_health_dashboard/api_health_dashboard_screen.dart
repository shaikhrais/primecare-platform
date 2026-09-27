import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'api_health_dashboard_screen_controller.dart';
import 'sections/api_health_dashboard_header_section.dart';
import 'sections/api_health_dashboard_summary_cards_section.dart';
import 'sections/api_health_dashboard_chart_overview_section.dart';
import 'sections/api_health_dashboard_recent_activity_section.dart';
import 'sections/api_health_dashboard_quick_actions_section.dart';


class ApiHealthDashboardScreen extends ConsumerWidget {
  const ApiHealthDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(api_health_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ApiHealthDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(api_health_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('api_health_dashboard_loading'), child: Semantics(label: 'api_health_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('api_health_dashboard_screen'),
                    child: Column(
                      children: [
                        ApiHealthDashboardHeaderSection(data: state.data),
                        ApiHealthDashboardSummaryCardsSection(data: state.data),
                        ApiHealthDashboardChartOverviewSection(data: state.data),
                        ApiHealthDashboardRecentActivitySection(data: state.data),
                        ApiHealthDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
