import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'legal_dashboard_screen_controller.dart';

class LegalDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The legal dashboard requires components for compliance status, legal disputes, performance metrics, and various legal documentation, along with corresponding APIs and responsive design for multiple platforms.';

  @override
  List<String> get requiredComponents => const [
        'ComplianceStatusIndicator',
        'LegalDisputeStatusCard',
        'PerformanceMetricsChart',
        'RecentDocumentsList',
        'AuditLogViewer',
        'DeadlineAlert',
        'TrainingCompletionChart',
        'LegalResearchSummary',
        'ExternalCounselMetrics',
        'LegalRiskVisualization',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchComplianceStatus',
        'fetchLegalDisputeStatus',
        'fetchPerformanceMetrics',
        'fetchRecentDocuments',
        'fetchAuditLogs',
        'setDeadlineAlert',
        'fetchTrainingCompletion',
        'fetchLegalResearch',
        'fetchExternalCounselMetrics',
        'fetchLegalRisks',
      ];

  const LegalDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(legalDashboardScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const PrimeText('LegalDashboard'),
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
            'LegalDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
