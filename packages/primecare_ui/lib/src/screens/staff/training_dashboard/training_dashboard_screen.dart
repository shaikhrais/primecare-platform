import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'training_dashboard_screen_controller.dart';
import 'sections/training_dashboard_header_section.dart';
import 'sections/training_dashboard_summary_cards_section.dart';
import 'sections/training_dashboard_chart_overview_section.dart';
import 'sections/training_dashboard_recent_activity_section.dart';
import 'sections/training_dashboard_quick_actions_section.dart';


class TrainingDashboardScreen extends ConsumerWidget {
  const TrainingDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(training_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('TrainingDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(training_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('training_dashboard_loading'), child: Semantics(label: 'training_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('training_dashboard_screen'),
                    child: Column(
                      children: [
                        TrainingDashboardHeaderSection(data: state.data),
                        TrainingDashboardSummaryCardsSection(data: state.data),
                        TrainingDashboardChartOverviewSection(data: state.data),
                        TrainingDashboardRecentActivitySection(data: state.data),
                        TrainingDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
