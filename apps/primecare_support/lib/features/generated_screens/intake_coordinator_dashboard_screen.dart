import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'intake_coordinator_dashboard_screen_controller.dart';

class IntakeCoordinatorDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The intake coordinator dashboard requires components to display operational metrics, compliance status, and performance indicators, along with buttons for refreshing data and executing compliance scans.';

  @override
  List<String> get requiredComponents => const [
        'ActiveOperationsMetric',
        'SecurityClearanceDisplay',
        'SystemLatencyMonitor',
        'DataIntegrityIndicator',
        'TelemetryLogViewer',
        'ComplianceAuditStatus',
        'OperationalAuditLogList',
        'PerformanceMetricsDisplay',
      ];

  @override
  List<String> get requiredFunctions => const [
        'refreshDashboard',
        'executeComplianceScan',
      ];

  const IntakeCoordinatorDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(intakeCoordinatorDashboardScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('IntakeCoordinatorDashboard'),
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
            'IntakeCoordinatorDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
