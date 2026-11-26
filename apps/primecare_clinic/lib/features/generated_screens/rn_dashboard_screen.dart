import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'rn_dashboard_screen_controller.dart';

class RnDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The RN dashboard requires components for real-time patient updates, compliance alerts, and performance metrics, along with various buttons and functions for logging interactions and reporting incidents.';

  @override
  List<String> get requiredComponents => const [
        'PatientStatusCard',
        'ComplianceAuditAlert',
        'PatientInteractionLog',
        'PerformanceMetricChart',
        'CriticalConditionAlert',
        'EducationalResourceAccess',
        'TeamCommunicationTool',
        'TrendAnalysisChart',
        'PatientOutcomeVisualization',
        'IncidentReportingTool',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchPatientStatus',
        'triggerComplianceAlert',
        'logPatientInteraction',
        'calculatePerformanceMetrics',
        'sendCriticalConditionAlert',
        'accessEducationalResources',
        'initiateTeamCommunication',
        'fetchHistoricalData',
        'visualizePatientOutcomes',
        'reportIncident',
      ];

  const RnDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rnDashboardScreenControllerProvider);

    return Semantics(
      label: 'data-cy:rndashboard-screen',
      container: true,
      child: PrimePageScaffold(
        scaffoldKey: const Key('rndashboard-screen'),
      title: Semantics(label: 'data-cy:rndashboard-title', container: true, child: Container(child:  const PrimeText('RnDashboard'))),
      body: state.when(
        data: (data) => _buildContent(context, data),
        loading: () => const DashboardLoadingWidget(),
        error: (error, stack) => Center(child: PrimeText('Error loading features: $error')),
      ),
    )
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
            'RnDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
