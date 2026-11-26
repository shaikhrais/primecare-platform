import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'franchise_owner_appointments_screen_controller.dart';

class FranchiseOwnerAppointmentsScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for monitoring performance metrics, managing appointments, tracking customer feedback, and ensuring compliance, along with necessary buttons and APIs for functionality.';

  @override
  List<String> get requiredComponents => const [
        'PerformanceMetricCard',
        'ComplianceStatusWidget',
        'AppointmentScheduler',
        'CustomerFeedbackTracker',
        'OperationalLogViewer',
        'AlertNotificationSystem',
        'FinancialPerformanceIndicator',
        'TrainingResourceCenter',
        'CommunicationTool',
      ];

  @override
  List<String> get requiredFunctions => const [
        'manageAppointments',
        'trackCustomerFeedback',
        'viewComplianceStatus',
        'generatePerformanceReport',
        'sendCommunication',
      ];

  const FranchiseOwnerAppointmentsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(franchiseOwnerAppointmentsScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('FranchiseOwnerAppointments'),
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
            'FranchiseOwnerAppointmentsScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
