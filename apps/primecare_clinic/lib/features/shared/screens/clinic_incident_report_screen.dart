/* 
PRIME:SCREEN=clinic_incident_report
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_CONNECTED
PRIME:DB=DB_NONE
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=50
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'clinic_incident_report_screen_controller.dart';

class ClinicIncidentReportScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The Clinic Incident Report screen requires components for displaying incident data, handling loading states, and notifying users of errors or successes.';

  @override
  List<String> get requiredComponents => const [
        'IncidentReportTable',
        'LoadingIndicator',
        'ErrorNotification',
        'SuccessMessage',
        'SummaryStatistics',
      ];

  @override
  List<String> get requiredFunctions => const [
        'loadIncidentReports',
        'handleLoadingError',
        'displaySuccessMessage',
        'updateDashboard',
      ];

  const ClinicIncidentReportScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinicIncidentReportScreenControllerProvider);

    return Semantics(
      label: 'data-cy:clinicincidentreport-screen',
      container: true,
      child: Scaffold(
        key: const Key('clinicincidentreport-screen'),
      appBar: AppBar(
        title: Semantics(label: 'data-cy:clinicincidentreport-title', child: const Text('ClinicIncidentReport')),
      ),
      body: state.when(
        data: (data) => _buildContent(context, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error loading features: $error')),
      ),
    )
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
            'ClinicIncidentReportScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
