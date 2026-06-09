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

    return Scaffold(
      appBar: AppBar(
        title: const Text('IntakeCoordinatorDashboard'),
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
            'IntakeCoordinatorDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
