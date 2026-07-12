import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'training_hub_dashboard_screen_controller.dart';
import 'sections/training_hub_dashboard_header_section.dart';
import 'sections/training_hub_dashboard_summary_cards_section.dart';
import 'sections/training_hub_dashboard_chart_overview_section.dart';
import 'sections/training_hub_dashboard_recent_activity_section.dart';
import 'sections/training_hub_dashboard_quick_actions_section.dart';


class TrainingHubDashboardScreen extends ConsumerWidget {
  const TrainingHubDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(training_hub_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('TrainingHubDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(training_hub_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('training_hub_dashboard_loading'), child: Semantics(label: 'training_hub_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('training_hub_dashboard_screen'),
                    child: Column(
                      children: [
                        TrainingHubDashboardHeaderSection(data: state.data),
                        TrainingHubDashboardSummaryCardsSection(data: state.data),
                        TrainingHubDashboardChartOverviewSection(data: state.data),
                        TrainingHubDashboardRecentActivitySection(data: state.data),
                        TrainingHubDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
