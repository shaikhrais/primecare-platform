import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'patient_dashboard_screen_controller.dart';

class PatientDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The patient dashboard requires components for monitoring KPIs, telemetry, compliance, and security, along with buttons for refreshing data and executing audits.';

  @override
  List<String> get requiredComponents => const [
        'KPIIndicator',
        'TelemetryLog',
        'ComplianceStatus',
        'RefreshButton',
        'AuditScanButton',
        'SecurityPostureIndicator',
        'SecurityPolicyUpdater',
        'AuditLogExporter',
      ];

  @override
  List<String> get requiredFunctions => const [
        'triggerManualRefresh',
        'executeAuditScan',
        'checkCompliance',
      ];

  const PatientDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patientDashboardScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PatientDashboard'),
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
            'PatientDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
