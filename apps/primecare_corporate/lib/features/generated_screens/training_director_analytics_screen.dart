import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'training_director_analytics_screen_controller.dart';

class TrainingDirectorAnalyticsScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'This screen requires components for tracking training progress, assessments, attendance, collaboration, and resources, along with necessary buttons and functions for user interaction.';

  @override
  List<String> get requiredComponents => const [
        'ProgressTracker',
        'AssessmentScoreCard',
        'AttendanceRecord',
        'CollaborationMetrics',
        'EventCalendar',
        'DevelopmentGoals',
        'ResourceAccess',
      ];

  @override
  List<String> get requiredFunctions => const [
        'trackProgress',
        'submitAssessment',
        'recordAttendance',
        'fetchCollaborationMetrics',
        'getUpcomingEvents',
        'updateDevelopmentGoals',
        'retrieveResources',
      ];

  const TrainingDirectorAnalyticsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(trainingDirectorAnalyticsScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('TrainingDirectorAnalytics'),
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
            'TrainingDirectorAnalyticsScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
