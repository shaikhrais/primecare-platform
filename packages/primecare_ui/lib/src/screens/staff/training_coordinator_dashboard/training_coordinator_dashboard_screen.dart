import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'training_coordinator_dashboard_screen_controller.dart';
import 'sections/training_coordinator_dashboard_header_section.dart';
import 'sections/training_coordinator_dashboard_summary_cards_section.dart';
import 'sections/training_coordinator_dashboard_chart_overview_section.dart';
import 'sections/training_coordinator_dashboard_recent_activity_section.dart';
import 'sections/training_coordinator_dashboard_quick_actions_section.dart';


class TrainingCoordinatorDashboardScreen extends ConsumerWidget {
  const TrainingCoordinatorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(training_coordinator_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('TrainingCoordinatorDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(training_coordinator_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('training_coordinator_dashboard_loading'), child: Semantics(label: 'training_coordinator_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('training_coordinator_dashboard_screen'),
                    child: Column(
                      children: [
                        TrainingCoordinatorDashboardHeaderSection(data: state.data),
                        TrainingCoordinatorDashboardSummaryCardsSection(data: state.data),
                        TrainingCoordinatorDashboardChartOverviewSection(data: state.data),
                        TrainingCoordinatorDashboardRecentActivitySection(data: state.data),
                        TrainingCoordinatorDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
