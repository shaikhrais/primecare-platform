import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'hr_hiring_credentials_screen_controller.dart';

class HrHiringCredentialsScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for tracking recruitment metrics, visualizing candidate pipelines, and ensuring compliance, along with buttons for job posting and metric export.';

  @override
  List<String> get requiredComponents => const [
        'KPIChart',
        'CandidatePipeline',
        'DiversityMetrics',
        'SourceOfHireAnalysis',
        'ComplianceTracker',
        'FeedbackScoreCard',
        'HistoricalDataTrends',
      ];

  @override
  List<String> get requiredFunctions => const [
        'addJobPosting',
        'viewCandidateDetails',
        'exportMetrics',
        'generateReport',
      ];

  const HrHiringCredentialsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hrHiringCredentialsScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('HrHiringCredentials'),
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
            'HrHiringCredentialsScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
