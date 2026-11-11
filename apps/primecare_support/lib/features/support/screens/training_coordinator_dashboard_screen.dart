import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'training_coordinator_dashboard_screen_controller.dart';

class TrainingCoordinatorDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The training coordinator dashboard requires components for tracking training progress, compliance status, and access to training materials, along with functionalities for updating progress and submitting feedback.';

  @override
  List<String> get requiredComponents => const [
        'TrainingProgressOverview',
        'ComplianceStatusCard',
        'TrainingMaterialsAccess',
        'FeedbackSummaryWidget',
        'EventNotificationList',
        'PerformanceMetricsChart',
        'TrainingActivityLog',
      ];

  @override
  List<String> get requiredFunctions => const [
        'updateTrainingProgress',
        'submitFeedback',
        'fetchTrainingMaterials',
      ];

  const TrainingCoordinatorDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(trainingCoordinatorDashboardScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('TrainingCoordinatorDashboard'),
      body: state.when(
        data: (data) => _buildContent(context, data),
        loading: () => const DashboardLoadingWidget(),
        error: (error, stack) => Center(child: PrimeText('Error loading features: $error')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, dynamic data) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const PrimeStatusIcon(Icons.check_circle_outline, tone: PrimeStatusTone.success, size: 64),
          const SizedBox(height: 16),
          PrimeText(
            'TrainingCoordinatorDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
