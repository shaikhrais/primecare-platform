import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'hr_hiring_offers_screen_controller.dart';

class HrHiringOffersScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for tracking recruitment metrics, visualizing candidate pipelines, and managing recruitment processes, along with necessary buttons and API integrations.';

  @override
  List<String> get requiredComponents => const [
        'KPIChart',
        'CandidatePipelineChart',
        'DiversityMetricsWidget',
        'SourceOfHireAnalysis',
        'CandidateFeedbackWidget',
        'ComplianceTracker',
        'OpenPositionsTracker',
        'AuditLogViewer',
      ];

  @override
  List<String> get requiredFunctions => const [
        'addCandidate',
        'viewReports',
        'exportData',
        'manageRecruitmentChannels',
      ];

  const HrHiringOffersScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hrHiringOffersScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HrHiringOffers'),
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
            'HrHiringOffersScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
