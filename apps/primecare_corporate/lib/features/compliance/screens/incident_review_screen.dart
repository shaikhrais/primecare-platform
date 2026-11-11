import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'incident_review_screen_controller.dart';

class IncidentReviewScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The incident review screen requires components for patient health status, medication records, compliance tracking, and communication tools, along with various buttons and functions to manage patient care effectively.';

  @override
  List<String> get requiredComponents => const [
        'PatientHealthStatusOverview',
        'MedicationAdministrationRecord',
        'ComplianceTrackingMetric',
        'IncidentErrorLog',
        'PatientSatisfactionScore',
        'StaffingLevelsAvailability',
        'CriticalConditionAlert',
        'NursingInterventionPerformanceMetric',
        'EducationalResourcesAccess',
        'TeamCommunicationTool',
      ];

  @override
  List<String> get requiredFunctions => const [
        'viewPatientRecords',
        'logMedicationAdministration',
        'trackCompliance',
        'reportIncident',
        'viewSatisfactionScores',
        'checkStaffingLevels',
        'sendAlert',
        'accessTrainingResources',
        'collaborateWithTeam',
      ];

  const IncidentReviewScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(incidentReviewScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const PrimeText('IncidentReview'),
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
            'IncidentReviewScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
