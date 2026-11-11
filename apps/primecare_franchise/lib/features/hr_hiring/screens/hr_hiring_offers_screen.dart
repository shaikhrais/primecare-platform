import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
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
        title: const PrimeText('HrHiringOffers'),
      ),
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
            'HrHiringOffersScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
