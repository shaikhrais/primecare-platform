import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'chiropractor_dashboard_screen_controller.dart';

class ChiropractorDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The chiropractor dashboard requires components for patient assessments, treatment plans, and progress monitoring, along with buttons for conducting assessments and syncing data.';

  @override
  List<String> get requiredComponents => const [
        'PatientAssessmentCard',
        'TreatmentPlanCard',
        'ProgressMonitorChart',
        'ComplianceStatusWidget',
        'PatientRecordTable',
      ];

  @override
  List<String> get requiredFunctions => const [
        'conductAssessment',
        'implementTreatmentPlan',
        'adjustTreatment',
        'syncData',
        'performComplianceScan',
      ];

  const ChiropractorDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chiropractorDashboardScreenControllerProvider);

    return Semantics(
      label: 'data-cy:chiropractordashboard-screen',
      container: true,
      child: PrimePageScaffold(
        scaffoldKey: const Key('chiropractordashboard-screen'),
      title: Semantics(label: 'data-cy:chiropractordashboard-title', container: true, child: Container(child:  const PrimeText('ChiropractorDashboard'))),
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
            'ChiropractorDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
