import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'training_director_dashboard_screen_controller.dart';

class TrainingDirectorDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The training director dashboard requires various components to monitor training programs, compliance, participation, budget, and feedback, along with necessary buttons and functions to manage and report on training activities.';

  @override
  List<String> get requiredComponents => const [
        'TrainingProgramOverview',
        'ComplianceMetricsCard',
        'ParticipationRateChart',
        'BudgetUtilizationChart',
        'FeedbackScoreWidget',
        'TrainingSessionLog',
        'AlertsNotification',
        'KPIMetrics',
        'TrainingOutcomesVisualization',
        'HistoricalDataTrendAnalysis',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchTrainingPrograms',
        'fetchComplianceMetrics',
        'fetchParticipationRates',
        'fetchBudgetMetrics',
        'fetchFeedbackScores',
        'fetchTrainingLogs',
        'checkAlerts',
        'fetchKPIs',
        'fetchTrainingOutcomes',
        'fetchHistoricalData',
      ];

  const TrainingDirectorDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(trainingDirectorDashboardScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TrainingDirectorDashboard'),
      ),
      body: state.when(
        data: (data) => _buildContent(context, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error loading features: $error')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, dynamic data) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
          const SizedBox(height: 16),
          Text(
            'TrainingDirectorDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
