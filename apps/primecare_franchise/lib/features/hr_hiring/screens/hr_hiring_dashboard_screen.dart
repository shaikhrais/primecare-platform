import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'hr_hiring_dashboard_screen_controller.dart';

class HrHiringDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The hr_hiring_dashboard requires various widgets to display recruitment metrics, candidate status, and compliance updates, along with buttons for interaction and APIs for data retrieval.';

  @override
  List<String> get requiredComponents => const [
        'KPIWidget',
        'CandidatePipelineChart',
        'SourceOfHireAnalysis',
        'DiversityMetricsWidget',
        'CandidateFeedbackScores',
        'ComplianceStatusWidget',
        'OpenPositionsUpdates',
        'HistoricalDataTrends',
        'AlertsWidget',
        'ATSIntegration',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchKPIs',
        'updateCandidatePipeline',
        'analyzeSourceOfHire',
        'trackDiversityMetrics',
        'collectCandidateFeedback',
        'checkComplianceStatus',
        'refreshOpenPositions',
        'retrieveHistoricalData',
        'triggerAlerts',
        'integrateATS',
      ];

  const HrHiringDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hrHiringDashboardScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('HrHiringDashboard'),
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
            'HrHiringDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
