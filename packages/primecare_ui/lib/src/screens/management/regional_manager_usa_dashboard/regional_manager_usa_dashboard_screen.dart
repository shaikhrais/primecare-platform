import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'regional_manager_usa_dashboard_screen_controller.dart';
import 'sections/regional_manager_usa_dashboard_header_section.dart';
import 'sections/regional_manager_usa_dashboard_summary_cards_section.dart';
import 'sections/regional_manager_usa_dashboard_chart_overview_section.dart';
import 'sections/regional_manager_usa_dashboard_recent_activity_section.dart';
import 'sections/regional_manager_usa_dashboard_quick_actions_section.dart';


class RegionalManagerUsaDashboardScreen extends ConsumerWidget {
  const RegionalManagerUsaDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(regional_manager_usa_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RegionalManagerUsaDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(regional_manager_usa_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('regional_manager_usa_dashboard_loading'), child: Semantics(label: 'regional_manager_usa_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('regional_manager_usa_dashboard_screen'),
                    child: Column(
                      children: [
                        RegionalManagerUsaDashboardHeaderSection(data: state.data),
                        RegionalManagerUsaDashboardSummaryCardsSection(data: state.data),
                        RegionalManagerUsaDashboardChartOverviewSection(data: state.data),
                        RegionalManagerUsaDashboardRecentActivitySection(data: state.data),
                        RegionalManagerUsaDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
